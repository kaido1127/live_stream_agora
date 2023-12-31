part of 'user_profile_remote_data_source.dart';

class _UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final FirebaseFirestore _firestore;

  _UserProfileRemoteDataSourceImpl({required FirebaseFirestore firestore}) : _firestore = firestore;

  /* createUserFromUserModel
   * Create a user object in database from UserModel with documentId is id of UserModel
   * return userModel if success and Future Error if failed
   */
  @override
  Future<UserModel> createUserFromUserModel({required UserModel userModel}) async {
    try {
      await _firestore.collection('users').doc(userModel.id).set(userModel.toJson());
      return userModel;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  /* getUserInfoFromId
  * Check the existence of a user in the database by id
  * if user exists in database , return UserModel else return null  */
  @override
  Future<UserModel?> getUserInfoFromId({required String id}) async {
    //Get user from firestore database by id
    final user = await _firestore.collection('users').doc(id).get();

    //return null if user don't exist else return userModel
    return (user.data() == null) ? null : UserModel.fromJson(user.data()!);
  }
}
