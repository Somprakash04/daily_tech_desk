/// Contract for authentication. A real API/Firebase implementation can replace
/// the fake implementation without changing the login UI or its BLoC.
abstract interface class AuthRepository {
  Future<void> login({required String email, required String password});

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  });
}
