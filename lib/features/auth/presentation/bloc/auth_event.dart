abstract class AuthEvent {}

class LoginPressed extends AuthEvent {
  final String username;
  final String password;

  LoginPressed({
    required this.username,
    required this.password,
  });
}

class CheckSession extends AuthEvent {}

class LogoutPressed extends AuthEvent {}