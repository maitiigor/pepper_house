class Validator {
  static String? validateName({required String? name}) {
    if (name!.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email!.isEmpty || email == null) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password!.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static String? validatePasswordConfirm(
      {required String? password, required String? passwordConfirm}) {
    if (passwordConfirm != password) {
      return 'Password confirmation does not match';
    }

    return null;
  }

  static String? validatePhoneNumber({required phoneNumber}) {
    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regExp = RegExp(pattern);

    if (phoneNumber!.isEmpty || phoneNumber == null) {
      return 'Phone Number can\'t be empty';
    } else if (!regExp.hasMatch(phoneNumber)) {
      return 'Invalid Phone Number format';
    }

    return null;
  }
}
