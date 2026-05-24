import '../../data/models/token_model.dart';
import '../repository/auth_repository.dart';

class RefreshTokenUseCase {

  final AuthRepository repository;

  RefreshTokenUseCase(
      this.repository,
      );

  Future<TokenModel> call(
      String refreshToken,
      ) {

    return repository.refreshToken(
      refreshToken:
      refreshToken,
    );

  }

}