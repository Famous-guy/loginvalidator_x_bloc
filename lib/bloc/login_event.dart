part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class AuthRequested extends LoginEvent {
  final String email;
  final String password;

  AuthRequested({required this.email, required this.password});
}

final class AuthLogOut extends LoginEvent {}
