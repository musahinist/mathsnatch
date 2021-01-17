import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationAppStartedEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationAppStartedEvent';
}

class AuthenticationAuthenticateEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationAuthenticateEvent';
}

class AuthenticationCreateGuestEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationCreateGuestEvent()';
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationSignUpEvent';
}

class AuthenticationLoggedOutEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationLoggedOutEvent';
}

class NoConnectionEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NoConnectionEvent';
}
