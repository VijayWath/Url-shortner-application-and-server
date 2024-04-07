part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

final class AuthLoginRequested extends AuthBlocEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

final class CheckForToken extends AuthBlocEvent {}

final class AuthCreateAccountRequested extends AuthBlocEvent {
  final String email;
  final String name;
  final String password;

  AuthCreateAccountRequested(
      {required this.email, required this.name, required this.password});
}
