import 'package:equatable/equatable.dart';

enum AuthSessionStatus { checking, signedOut, selectingInterests, signedIn }

class AuthSessionState extends Equatable {
  const AuthSessionState({
    this.status = AuthSessionStatus.checking,
    this.interestIds = const <String>[],
  });

  final AuthSessionStatus status;
  final List<String> interestIds;

  @override
  List<Object> get props => <Object>[status, interestIds];
}