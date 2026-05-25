import '../models/token_model.dart';

abstract class AuthRemoteDatasource {

  Future<TokenModel> login({
    required String username,
    required String password,
  });

  Future<TokenModel> refreshToken({
    required String refreshToken,
  });

  Future<void> logout({
    required String refreshToken,
  });
}