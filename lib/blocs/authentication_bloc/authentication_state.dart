part of 'authentication_bloc.dart';

// Defines the various states of authentication
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final MyUser? user;

  // Private cons to prevent direct instantiation
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown, // Default status is unknown
    this.user, // User is optional and can be null
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(MyUser myUser)
      : this._(status: AuthenticationStatus.authenticated, user: myUser);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  // Compare states based on status and userId
  @override
  List<Object?> get props => [status, user];

}