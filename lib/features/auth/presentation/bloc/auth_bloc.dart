import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/session_manager.dart';
import '../../../../core/auth/token_storage.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase login;

  final TokenStorage storage;

  final SessionManager session;

  AuthBloc(this.login, this.storage, this.session) : super(AuthInitial()) {
    on<LoginPressed>(_login);

    on<CheckSession>(_checkSession);

    on<LogoutPressed>(_logout);
  }

  Future<void> _login(LoginPressed event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      final token = await login(
        username: event.username,

        password: event.password,
      );

      await storage.save(
        access: token.accessToken,

        refresh: token.refreshToken,
      );

      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _checkSession(
    CheckSession event,
    Emitter<AuthState> emit,
  ) async {
    final token = await session.getValidToken();

    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _logout(LogoutPressed event, Emitter<AuthState> emit) async {
    await session.logout();

    emit(AuthUnauthenticated());
  }
}
