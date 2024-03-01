class Auth {
  Future createAccountWithEmail(String email, String password) {
    print('Create account with email: $email and password: $password');

    return Future.delayed(const Duration(seconds: 1), () => true);
  }

  Future signInWithEmail(String email, String password) {
    print('Sign in with email: $email and password: $password');

    return Future.delayed(const Duration(seconds: 1), () => true);
  }
}
