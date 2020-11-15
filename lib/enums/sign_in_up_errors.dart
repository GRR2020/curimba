enum SignInUpErrors { UserFound, UserNotFound, PasswordMismatch }

extension SignInUpErrorsCode on SignInUpErrors {
  int get code {
    switch (this) {
      case SignInUpErrors.UserNotFound:
        return -1;
      case SignInUpErrors.UserFound:
        return -2;
      case SignInUpErrors.PasswordMismatch:
        return -3;
      default:
        return 0;
    }
  }
}