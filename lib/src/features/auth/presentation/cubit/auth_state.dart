abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoadSuccess extends AuthState {}

class AuthSignOut extends AuthState {}

class AuthLoadFailed extends AuthState {
  final String message;
  AuthLoadFailed(this.message);
}
