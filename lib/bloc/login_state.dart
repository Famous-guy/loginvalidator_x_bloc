part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final String uid;
  final String email;
  final String referral;

  LoginSuccess({
    required this.uid,
    required this.email,
    required this.referral,
  });
}

final class LoginFailure extends LoginState {
  final String msg;

  LoginFailure({
    required this.msg,
  });
}

final class LoginLoad extends LoginState {}
