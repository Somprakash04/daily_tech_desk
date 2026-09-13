import 'package:daily_tech_desk/features/authentication/domain/repositories/auth_repository.dart';

/// Development-only implementation. It deliberately performs no authentication
/// or persistence; replace it with a remote implementation in Phase 2.
class FakeAuthRepository implements AuthRepository {
  @override
  Future<void> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
  }

  @override
  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
  }
}
