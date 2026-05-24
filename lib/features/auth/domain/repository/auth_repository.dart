import '../../data/models/token_model.dart';

abstract class AuthRepository {

  Future<TokenModel> login({
    required String username,
    required String password,
  });

  Future<TokenModel> refreshToken({
    required String refreshToken,
  });

}