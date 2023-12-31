part of 'auth_repository.dart';

class _AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserProfileRemoteDataSource _userProfileRemoteDataSource;

  _AuthRepositoryImpl(
      {required AuthRemoteDataSource authRemoteDataSource,
      required UserProfileRemoteDataSource userProfileRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource,
        _userProfileRemoteDataSource = userProfileRemoteDataSource;


  /*
  * login
  * get user from login function of remote datasource
  * if user exists , return UserEntity object from user
  * else call createUserFromUserModel from remote datasource
   */
  @override
  Future<UserEntity?> login() async {
    try {
      //Login
      final User? userAuth = await _authRemoteDataSource.login();

      //if auth success
      if (userAuth != null) {
        //Check this user in database
        final UserModel? userModel =
            await _userProfileRemoteDataSource.getUserInfoFromId(id: userAuth.uid);

        if (userModel != null) {
          //if exist , return
          return UserEntity.fromModel(userModel);
        } else {
          // if isn't exist created this user
          final UserModel userModelCreated = await _userProfileRemoteDataSource
              .createUserFromUserModel(userModel: UserModel.fromUserAuth(userAuth));
          return UserEntity.fromModel(userModelCreated);
        }
      }

      return null;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> logout() async {
    await _authRemoteDataSource.logout();
  }

  /* getUserEntity
  * auth with auth remote data source and return userAuth
  * if user auth exists , get userModel from database with id and return userEntity from userModel
  * else return null
   */
  @override
  Future<UserEntity?> getUserEntity() async {
    try {
      //Get check user auth
      final User? userAuth = _authRemoteDataSource.getCurrentUser();
      if (userAuth == null) {
        return null;
      } else {
        //if user auth exist , return userModel from database by id
        final UserModel? userModel =
            await _userProfileRemoteDataSource.getUserInfoFromId(id: userAuth.uid);

        //if user exist in database , return userEntity , else return null
        return (userModel != null) ? UserEntity.fromModel(userModel) : null;
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
