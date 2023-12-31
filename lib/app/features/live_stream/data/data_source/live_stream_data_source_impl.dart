part of 'live_stream_data_source.dart';

class _LiveStreamDataSourceImpl implements LiveStreamDataSource {
  final FirebaseFirestore _firestore;

  _LiveStreamDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> _collectionDelete(CollectionReference collectionRef) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    QuerySnapshot querySnapshot = await collectionRef.get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  /* leaveStream
  * if user role is host , remove channel from the database
  * if user role isn't host , remove the user from list_user of database
  * */
  @override
  Future<void> leaveStream(
      {required UserLiveStreamModel user, required String channelName}) async {
    if (user.roleType == LiveStreamRoleType.host) {
      //clear list user of live stream

      await _collectionDelete(
          _listUserOnLiveStreamRef(channelName: channelName));
      await _collectionDelete(
          _listActionOfLiveStreamRef(channelName: channelName));
      await _collectionDelete(
          _listGiftOfLiveStreamRef(channelName: channelName));

      await _collectionDelete(
          _blackListUserOnLiveStreamRef(channelName: channelName));

      // var listUserQuery =
      //     await _listUserOnLiveStreamRef(channelName: channelName).get();

      // for (var doc in listUserQuery.docs) {
      //   await doc.reference.delete();
      // }

      // //cleart list gift of live stream
      // var listGiftQuery =
      //     await _listGiftOfLiveStreamRef(channelName: channelName).get();

      // for (var doc in listGiftQuery.docs) {
      //   await doc.reference.delete();
      // }
      // //cleart list action of live stream
      // var listActionQuery =
      //     await _listActionOfLiveStreamRef(channelName: channelName).get();

      // for (var doc in listActionQuery.docs) {
      //   await doc.reference.delete();
      // }

      // //clear blacklist of live stream
      // var blacklistQuery =
      //     await _blackListUserOnLiveStreamRef(channelName: channelName).get();

      // for (var doc in blacklistQuery.docs) {
      //   await doc.reference.delete();
      // }

      //delete channel doc
      await _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .delete();
    } else {
      //remove user left channel in database
      await _listUserOnLiveStreamRef(channelName: channelName)
          .doc(user.id)
          .delete();
      _addAction(
          actionModel: ActionModel(
              userName: user.name,
              userId: user.id,
              type: ActionType.left,
              description: "${user.name} rời livestream",
              createdAt: DateTime.now().millisecondsSinceEpoch),
          channelName: channelName);
    }
  }

  /* sendInvitation
   * replace user with user with invitation in database
   */
  @override
  Future<void> sendInvitation(
      {required UserLiveStreamModel userInvited,
      required String channelName,
      required Invitation? invitation}) async {
    //Add new user invited with invitation to database
    // if invitation == null (host remove them from this list) ,set their role are audience
    await _listUserOnLiveStreamRef(channelName: channelName)
        .doc(userInvited.id)
        .update({
      "invitation": invitation?.toJson(),
      "role_type":
          (invitation == null) ? LiveStreamRoleType.audience.name : null
    });

    //Add new user invited with invitation to database
    // if invitation == null (host remove them from this list) ,set their role are audience
  }

  /* replyInvitation
   * replace user with user with response to invitation in database
   */
  @override
  Future<void> replyInvitation(
      {required UserLiveStreamModel userInvited,
      required String channelName,
      required Invitation reply}) async {
    // if user accept invitation , change their role to broadcaster
    // Else copyWith roleType null will set their role to old role

    await _listUserOnLiveStreamRef(channelName: channelName)
        .doc(userInvited.id)
        .update({
      "invitation": reply.toJson(),
      "role_type":
          (reply.isAccept ?? false) ? LiveStreamRoleType.broadcaster.name : null
    });
  }

  /* changeRemoteUserRole
   * replace old user with user with new role
   */
  @override
  Future<void> changeRemoteUserRole(
      {required UserLiveStreamModel userLiveStreamModel,
      required LiveStreamRoleType newRole,
      required String channelName}) async {
    //update user with new role
    await _listUserOnLiveStreamRef(channelName: channelName)
        .doc(userLiveStreamModel.id)
        .update({"role_type": newRole.name});
  }

  //Get collectionReference of list user joined live stream
  CollectionReference<Map<String, dynamic>> _listUserOnLiveStreamRef(
          {required String channelName}) =>
      _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .collection('list_user');

  //Get collectionReference of list user blocked in live stream
  CollectionReference<Map<String, dynamic>> _blackListUserOnLiveStreamRef(
          {required String channelName}) =>
      _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .collection('blacklist');
  //Get collectionReference of list gift on livestream channel
  CollectionReference<Map<String, dynamic>> _listGiftOfLiveStreamRef(
          {required String channelName}) =>
      _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .collection('list_gift');
  //Get collectionReference of list action on livestream channel
  CollectionReference<Map<String, dynamic>> _listActionOfLiveStreamRef(
          {required String channelName}) =>
      _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .collection('list_action');

  //Get collectionReference of user by id
  DocumentReference<Map<String, dynamic>> _getUserRefById(String id) =>
      _firestore.collection('users').doc(id);

  /*sendGift
  * update new gift to list gift of database
  * Add the coin of the gift to the "coin" of the host profile
  * Subtract the coin of the gift from the "coin" of the giver profile
   */
  @override
  Future<void> sendGift(
      {required String channelName, required DonateModel donateModel}) async {
    //get channel from database by channelName
    final channelRef = await _firestore
        .collection('live_stream_channel')
        .doc(channelName)
        .get();
    //if channel exists and has data
    if (channelRef.exists && channelRef.data() != null) {
      //get channelModel from json
      final ChannelModel channelModel =
          ChannelModel.fromJson(channelRef.data()!);
      //get id of host
      final String hostId = channelModel.host.id;
      //add and update coin on user profile of host in database
      await _getUserRefById(hostId).update({
        "coin": FieldValue.increment(donateModel.coin),
      });

      //subtract and update coin on user profile of giver in database
      await _getUserRefById(donateModel.giverId).update({
        "coin": FieldValue.increment(-donateModel.coin),
      });

      // get donate infomation of user
      final donateOfUser =
          await _listGiftOfLiveStreamRef(channelName: channelName)
              .doc(donateModel.giverId)
              .get();

      //if user has donate history
      if (donateOfUser.exists && donateOfUser.data() != null) {
        await _listGiftOfLiveStreamRef(channelName: channelName)
            .doc(donateModel.giverId)
            .update({
          "coin": FieldValue.increment(donateModel.coin),
        });
      } else {
        //if user hasn't donate history
        await _listGiftOfLiveStreamRef(channelName: channelName)
            .doc(donateModel.giverId)
            .set(donateModel.toJson());
      }
      //update list action on channel
      _addAction(
          actionModel: ActionModel(
              userName: donateModel.giverName,
              userId: donateModel.giverId,
              type: ActionType.donate,
              description:
                  "${donateModel.giverName} donate ${donateModel.name} worth ${donateModel.name}",
              createdAt: DateTime.now().millisecondsSinceEpoch,
              giftItem: GiftItem(
                  name: donateModel.name,
                  coin: donateModel.coin,
                  valueLevel: donateModel.valueLevel)),
          channelName: channelName);
    }
  }

  Future<void> _addAction(
      {required ActionModel actionModel, required String channelName}) async {
    await _listActionOfLiveStreamRef(channelName: channelName)
        .add(actionModel.toJson());
  }

  /*blockUser
  // add id of blocked user to blacklist of blocker in database
  */
  @override
  Future<void> blockUser(
      {required String blockerId,
      required BlockedUserModel blockedUser}) async {
    try {
      await _firestore
          .collection('users')
          .doc(blockerId)
          .collection("blacklist_user")
          .doc(blockedUser.id)
          .set(blockedUser.toJson());
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /*blockUserFromChannel
  // add blocked user infomation and block type to blacklist of channel in database
  */
  @override
  Future<void> blockUserFromChannel(
      {required String channelName,
      required BlockedUserModel blockedUser}) async {
    try {
      await _firestore
          .collection("live_stream_channel")
          .doc(channelName)
          .collection("blacklist")
          .doc(blockedUser.id)
          .set(blockedUser.toJson());
      if (blockedUser.blockType == BlockType.blockFromChannel ||
          blockedUser.blockType == BlockType.forever) {
        _listUserOnLiveStreamRef(channelName: channelName)
            .doc(blockedUser.id)
            .delete();
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /*blockedUserModelByBlockerId
  // check if a user is blocked by another user or not
  // if user blocked , return null
  // else return BlockedUserModel
   */
  @override
  Future<BlockedUserModel?> blockedUserModelByBlockerId(
      {required String blockerId, required String blockedUserId}) async {
    final blockedUserRef = await _firestore
        .collection('users')
        .doc(blockerId)
        .collection('blacklist_user')
        .doc(blockedUserId)
        .get();
    if (!blockedUserRef.exists) {
      return null;
    } else {
      return (blockedUserRef.data() == null)
          ? null
          : BlockedUserModel.fromJson(blockedUserRef.data()!);
    }
  }

  /*blockedUserModelByChannel
  // check if a user is blocked by channel or not
  // if user blocked , return null
  // else return BlockedUserModel
   */
  @override
  Future<BlockedUserModel?> blockedUserModelByChannel(
      {required String channelName, required String blockedUserId}) async {
    try {
      final blockedUserRef = await _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .collection('blacklist')
          .doc(blockedUserId)
          .get();
      if (!blockedUserRef.exists) {
        return null;
      } else {
        return (blockedUserRef.data() == null)
            ? null
            : BlockedUserModel.fromJson(blockedUserRef.data()!);
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  //Remove block state of a user from another user's profile
  @override
  Future<void> unblockUser(
      {required String blockerId, required String blockedUserId}) async {
    try {
      await _firestore
          .collection('users')
          .doc(blockerId)
          .collection("blacklist_user")
          .doc(blockedUserId)
          .delete();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> unblockUserFromChannel(
      {required String blockedUserId, required String channelName}) async {
    await _blackListUserOnLiveStreamRef(channelName: channelName)
        .doc(blockedUserId)
        .delete();
  }

  //Future<void> kickUser({re})

  //return stream list blocked user on channel
  @override
  Stream<List<BlockedUserModel>> getBlacklistUserOnLiveStream(
      {required String channelName}) {
    try {
      return _blackListUserOnLiveStreamRef(channelName: channelName)
          .snapshots()
          .map((event) {
        return event.docs
            .map((blockedUser) => BlockedUserModel.fromJson(blockedUser.data()))
            .toList();
      });
    } on Exception catch (e) {
      return Stream.value([]);
    }
  }

  //return the last number element of list action
  @override
  Stream<List<ActionModel>> getTailOfListAction(
      {required String channelName, required int range}) {
    try {
      return _listActionOfLiveStreamRef(channelName: channelName)
          .orderBy('created_at', descending: true)
          .limit(range)
          .snapshots()
          .map((event) {
        return event.docs
            .map((actionRef) => ActionModel.fromJson(actionRef.data()))
            .toList();
      });
    } on Exception catch (e) {
      return Stream.value([]);
    }
  }

  //return stream list donate order by coin (ranking)
  @override
  Stream<List<DonateModel>> getListDonateOrderByCoin(
      {required String channelName}) {
    try {
      return _listGiftOfLiveStreamRef(channelName: channelName)
          .orderBy("coin", descending: true)
          .snapshots()
          .map((event) {
        return event.docs
            .map((donateRef) => DonateModel.fromJson(donateRef.data()))
            .toList();
      });
    } catch (e) {
      return Stream.value([]);
    }
  }

  /*getListUser
  * return stream list user on live stream from database by channelName
   */
  @override
  Stream<List<UserLiveStreamModel>> getListUser({required String channelName}) {
    try {
      return _listUserOnLiveStreamRef(channelName: channelName)
          .snapshots()
          .map((event) {
        return event.docs
            .map((userRef) => UserLiveStreamModel.fromJson(userRef.data()))
            .toList();
      });
    } on Exception catch (e) {
      return Stream.value([]);
    }
  }

  //return stream localUser Model
  @override
  Stream<UserLiveStreamModel?> getLocalUser(
      {required String localUserId, required String channelName}) {
    try {
      return _listUserOnLiveStreamRef(channelName: channelName)
          .doc(localUserId)
          .snapshots()
          .map((event) => event.data() == null
              ? null
              : UserLiveStreamModel.fromJson(event.data()!));
    } on Exception catch (e) {
      return Stream.error(e);
    }
  }

  /* joinStream
  * if user role is host , create new channel in database
  * if user role isn't host , add user to list_user of channel in database
   */
  @override
  Future<void> joinStream(
      {required UserLiveStreamModel userLiveStreamModel,
      required String channelName}) async {
    //Determine the role of the user who wants to enter the channel
    final int time = DateTime.now().millisecondsSinceEpoch;

    if (userLiveStreamModel.roleType == LiveStreamRoleType.host) {
      //create live stream channel in database

      //Get blacklist of host in database
      final blacklistOfHostRef = await _firestore
          .collection('users')
          .doc(userLiveStreamModel.id)
          .collection('blacklist_user')
          .get();

      final ChannelModel channelModel = ChannelModel(
          name: channelName, host: userLiveStreamModel, createdAt: time);
      //create channel in database
      await _firestore
          .collection('live_stream_channel')
          .doc(channelName)
          .set(channelModel.toJson());
      // add blacklist of host to blacklist of channel
      for (var blockedUser in blacklistOfHostRef.docs) {
        await _firestore
            .collection('live_stream_channel')
            .doc(channelName)
            .collection('blacklist')
            .doc(blockedUser.id)
            .set(blockedUser.data());
      }
    }
    //add new audience of live stream channel in database
    await _listUserOnLiveStreamRef(channelName: channelName)
        .doc(userLiveStreamModel.id)
        .set(userLiveStreamModel.toJson());

    _addAction(
        actionModel: ActionModel(
            userName: userLiveStreamModel.name,
            userId: userLiveStreamModel.id,
            type: ActionType.join,
            description:
                "${userLiveStreamModel.name} ${(userLiveStreamModel.roleType == LiveStreamRoleType.host) ? "bắt đầu" : "tham gia"} livestream",
            createdAt: time),
        channelName: channelName);
  }
}
