import 'package:daily_tech_desk/features/authentication/domain/repositories/auth_session_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local UI session only. It contains no credentials or backend authentication.
class LocalAuthSessionRepository implements AuthSessionRepository {
  static const String _signedInKey = 'demo_signed_in';
  static const String _interestsKey = 'demo_interest_ids';

  @override
  Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_signedInKey);
    await preferences.remove(_interestsKey);
  }

  @override
  Future<List<String>> getInterestIds() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(_interestsKey) ?? const <String>[];
  }

  @override
  Future<bool> hasActiveSession() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_signedInKey) ?? false;
  }

  @override
  Future<void> saveSession({required List<String> interestIds}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_signedInKey, true);
    await preferences.setStringList(_interestsKey, interestIds);
  }
}
