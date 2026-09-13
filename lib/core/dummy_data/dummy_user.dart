import 'package:daily_tech_desk/core/models/app_user.dart';

abstract final class DummyUser {
  static const AppUser current = AppUser(
    id: 'demo-user-001',
    fullName: 'Alex Morgan',
    email: 'alex@example.com',
  );
}
