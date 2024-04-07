import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:url_shortner_service/models/responseModel.dart';
import 'package:url_shortner_service/models/userModel.dart';
import 'package:url_shortner_service/respositories/UserRepository.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserRepository userRepository;
  AuthBlocBloc(this.userRepository) : super(AuthBlocInitial()) {
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

      ResponseModel res =
          await userRepository.userCreateAccount(email, password, name);

      if (res.data == null) {
        emit(AuthFailuare(error: res.error.toString()));
      }

      emit(AuthSuccess(user: res.data));
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

      ResponseModel res = await userRepository.userLogin(email, password);

      if (res.data == null) {
        emit(AuthFailuare(error: res.error.toString()));
        return;
      }

      emit(AuthSuccess(user: res.data));
    } catch (e) {
      emit(
        AuthFailuare(
          error: e.toString(),
        ),
      );
    }
  }
}
