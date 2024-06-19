class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(r"([A-ZÀ-ÿ][-,A-ZÀ-ÿ. ']+[ ]*)+");
    if (value != null && value.isEmpty) {
      return 'Por favor, digite seu nome';
    }
    if (value != null && !condition.hasMatch(value)) {
      return 'Por favor, digite um nome válido';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (value != null && value.isEmpty) {
      return 'Por favor, digite seu email';
    }
    if (value != null && !condition.hasMatch(value)) {
      return 'Por favor, digite um email válido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition =
        RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
    if (value != null && value.isEmpty) {
      return 'Por favor, digite sua senha';
    }
    if (value != null && !condition.hasMatch(value)) {
      return 'Por favor, digite uma senha válida';
    }
    return null;
  }

  static String? validateConfirmPassword(String? first, String? second) {
    if (first != second) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
