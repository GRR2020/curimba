
enum AuthErrors {
  UserFound,
  UserNotFound,
  PasswordMismatch,
}

extension AuthErrorsExtension on AuthErrors {
  int get code {
    switch (this) {
      case AuthErrors.UserNotFound:
        return -1;
      case AuthErrors.UserFound:
        return -2;
      case AuthErrors.PasswordMismatch:
        return -3;
      default:
        return 0;
    }
  }
}