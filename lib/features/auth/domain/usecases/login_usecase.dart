import '../../data/models/token_model.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {

  final AuthRepository repository;

  LoginUseCase(
      this.repository,
      );

  Future<TokenModel> call({

    required String username,

    required String password,

  }) {

    return repository.login(
      username: username,
      password: password,
    );

  }

}