import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/token_model.dart';

class AuthRepositoryImpl
    implements AuthRepository {

  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(
      this.remote,
      );

  @override
  Future<TokenModel> login({
    required String username,
    required String password,
  }) {

    return remote.login(
      username: username,
      password: password,
    );

  }

  @override
  Future<TokenModel> refreshToken({
    required String refreshToken,
  }) {

    return remote.refreshToken(
      refreshToken:
      refreshToken,
    );

  }

}