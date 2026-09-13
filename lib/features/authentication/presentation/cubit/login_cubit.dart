import 'package:daily_tech_desk/features/authentication/domain/repositories/auth_repository.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginState(status: LoginStatus.submitting));
    try {
      await _authRepository.login(email: email, password: password);
      emit(const LoginState(status: LoginStatus.success));
    } catch (_) {
      emit(
        const LoginState(
          status: LoginStatus.failure,
          errorMessage: 'Unable to sign in. Please try again.',
        ),
      );
    }
  }
}
