import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/auth/data/repository/auth_repository_provider.dart';
import 'package:test_agora/app/features/auth/domain/user_entity.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<UserEntity?> build() async {
    return ref.read(authRepositoryProvider).getUserEntity();
  }

  /* logout
  * change current state to loading and await logout function from repository and change current state to null*/
  Future<void> logout() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }

  /* login
  * change current state to loading and await current user from login function of repository
  * and change current state to value of result from the function*/
  Future<void> login() async {
    state = const AsyncLoading();
    final UserEntity? userEntity = await ref.read(authRepositoryProvider).login();
    state = AsyncData(userEntity);
  }
}
