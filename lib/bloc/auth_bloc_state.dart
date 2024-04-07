part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthFailuare extends AuthBlocState {
  final String error;

  AuthFailuare({required this.error});
}

final class AuthSuccess extends AuthBlocState {
  final UserModel user;

  AuthSuccess({required this.user});
}
