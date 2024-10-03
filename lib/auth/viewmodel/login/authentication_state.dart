abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationWithToken extends AuthenticationState {}

class AuthenticationWithTokenField extends AuthenticationState {}

class AuthenticationWithEmail extends AuthenticationState {}

class AuthenticationSignUp extends AuthenticationState {}

class AuthenticationSignUpError extends AuthenticationState {}

class AuthenticationRememberMe extends AuthenticationState {}

class AuthenticationChangeFormType extends AuthenticationState {}

class AuthenticationField extends AuthenticationState {}

