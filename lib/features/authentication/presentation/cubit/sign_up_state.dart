import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, submitting, success, failure }

class SignUpState extends Equatable {
  const SignUpState({this.status = SignUpStatus.initial, this.errorMessage});

  final SignUpStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[status, errorMessage];
}
