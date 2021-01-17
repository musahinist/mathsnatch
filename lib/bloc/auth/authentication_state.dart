import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {
  @override
  String toString() => 'AuthenticationInitialState';
}

class AuthenticationSuccesState extends AuthenticationState {
  @override
  String toString() => 'AuthenticationSuccesState';
}

class NoConnectionState extends AuthenticationState {
  @override
  String toString() => 'NoConnectionState';
}
