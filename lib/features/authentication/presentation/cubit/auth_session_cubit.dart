import 'package:daily_tech_desk/features/authentication/domain/repositories/auth_session_repository.dart';
import 'package:daily_tech_desk/features/authentication/presentation/cubit/auth_session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSessionCubit extends Cubit<AuthSessionState> {
  AuthSessionCubit(this._repository) : super(const AuthSessionState());

  final AuthSessionRepository _repository;

  Future<void> restore() async {
    final bool signedIn = await _repository.hasActiveSession();
    if (!signedIn) {
      emit(const AuthSessionState(status: AuthSessionStatus.signedOut));
      return;
    }
    final List<String> interests = await _repository.getInterestIds();
    emit(AuthSessionState(status: AuthSessionStatus.signedIn, interestIds: interests));
  }

  void startInterestSelection() {
    emit(const AuthSessionState(status: AuthSessionStatus.selectingInterests));
  }

  Future<void> saveInterests(List<String> interestIds) async {
    await _repository.saveSession(interestIds: interestIds);
    emit(AuthSessionState(status: AuthSessionStatus.signedIn, interestIds: interestIds));
  }

  Future<void> logout() async {
    await _repository.clearSession();
    emit(const AuthSessionState(status: AuthSessionStatus.signedOut));
  }
}