import 'package:daily_tech_desk/features/authentication/domain/repositories/auth_repository.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState());

  final AuthRepository _authRepository;

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(const SignUpState(status: SignUpStatus.submitting));
    try {
      await _authRepository.register(
        fullName: fullName,
        email: email,
        password: password,
      );
      emit(const SignUpState(status: SignUpStatus.success));
    } catch (_) {
      emit(
        const SignUpState(
          status: SignUpStatus.failure,
          errorMessage: 'Unable to create your account. Please try again.',
        ),
      );
    }
  }
}
