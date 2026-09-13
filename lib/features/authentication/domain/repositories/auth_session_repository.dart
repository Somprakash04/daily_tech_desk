abstract interface class AuthSessionRepository {
  Future<bool> hasActiveSession();
  Future<List<String>> getInterestIds();
  Future<void> saveSession({required List<String> interestIds});
  Future<void> clearSession();
}