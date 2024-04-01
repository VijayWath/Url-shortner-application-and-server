import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthCreateAccountRequested>(_onAuthCreateAccountRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
  }
  void _onAuthCreateAccountRequested(event, emit) async {
    try {
      final String email = event.email;
      final String name = event.name;
      final String password = event.password;

      if (password.length < 6) {
        emit(AuthFailuare(error: "Lenth <6"));
        return;
      }
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 1));
      emit(AuthCreateAccountSuccess(uid: "$email - $password - $name"));
    } catch (e) {
      emit(
        AuthFailuare(
          error: e.toString(),
        ),
      );
    }
  }

  void _onAuthLoginRequested(event, emit) async {
    try {
      final String email = event.email;
      final String password = event.password;

      if (password.length < 6) {
        emit(AuthFailuare(error: "Lenth <6"));
        return;
      }

      await Future.delayed(const Duration(seconds: 1));
      emit(AuthCreateAccountSuccess(uid: "$email - $password"));
    } catch (e) {
      emit(
        AuthFailuare(
          error: e.toString(),
        ),
      );
    }
  }
}
