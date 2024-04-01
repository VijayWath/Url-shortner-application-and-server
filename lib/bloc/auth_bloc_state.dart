part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoginSuccess extends AuthBlocState {}

final class AuthFailuare extends AuthBlocState {
  final String error;

  AuthFailuare({required this.error});
}

final class AuthCreateAccountSuccess extends AuthBlocState {
  final String uid;

  AuthCreateAccountSuccess({required this.uid});
}
