import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
  });

  final String id;
  final String fullName;
  final String email;

  String get firstName => fullName.trim().split(' ').first;

  @override
  List<Object> get props => <Object>[id, fullName, email];
}
