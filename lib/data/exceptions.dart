abstract class Failure implements Exception {
  const Failure();

  String get message;

  @override
  String toString() {
    return '$runtimeType Exception';
  }
}

class GeneralException extends Failure {
  const GeneralException();

  @override
  String get message => 'Ocorreu um erro. Por favor, tente novamente mais tarde.';
}

// Exceções de API

class APIException extends Failure {
  const APIException({
    required this.code,
    this.textCode,
  });

  final int code;
  final String? textCode;

  @override
  String get message {
    if (textCode != null) {
      switch (textCode) {
        case 'invalid-headers':
        case 'validation-failed':
          return 'Requisição inválida. Verifique os dados e tente novamente.';
        default:
          return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
      }
    }
    switch (code) {
      case 400:
        return 'Requisição inválida. Verifique os dados e tente novamente.';
      case 401:
        return 'Usuário não autorizado para acessar este recurso no momento. Por favor, faça login novamente.';
      case 404:
        return 'Não foi possível concluir esta operação. Por favor, tente novamente mais tarde.';
      case 503:
        return 'Serviço indisponível no momento. Por favor, tente novamente mais tarde.';
      default:
        return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
    }
  }
}

// Exceções de Serviços

class AuthException extends Failure {
  const AuthException({
    required this.code,
  });

  final String code;

  @override
  String get message {
    switch (code) {
      case 'session-expired':
      case 'invalid-jwt':
      case 'invalid-headers':
      case 'user-not-authenticated':
        return 'Sua sessão expirou. Por favor, faça login novamente.';
      case 'email-already-exists':
        return 'O e-mail informado já está em uso. Verifique suas informações ou crie uma nova conta.';
      case 'user-not-found':
      case 'wrong-password':
        return 'E-mail ou senha incorretos. Verifique suas informações ou crie uma nova conta.';
      case 'network-request-failed':
        return 'Não foi possível conectar-se ao servidor remoto. Verifique sua conexão e tente novamente.';
      case 'too-many-requests':
        return 'Muitas tentativas de login. Por favor, tente novamente mais tarde.';
      case 'internal':
        return 'Não foi possível criar sua conta neste momento. Verifique suas informações e tente novamente.';
      default:
        return 'Ocorreu um erro ao autenticar. Por favor, tente novamente mais tarde.';
    }
  }
}

class SecureStorageException extends Failure {
  const SecureStorageException();

  @override
  String get message => 'Ocorreu um erro ao acessar o Armazenamento Seguro.';
}

class CacheException extends Failure {
  const CacheException();

  @override
  String get message => 'Ocorreu um erro ao acessar o Cache Local.';
}

// Exceções do Sistema

class ConnectionException extends Failure {
  const ConnectionException({
    required this.code,
  });

  final String code;

  @override
  String get message {
    switch (code) {
      case 'connection-error':
        return 'Não foi possível conectar-se ao servidor remoto. Verifique sua conexão e tente novamente.';
      default:
        return 'Ocorreu um erro interno. Por favor, tente novamente mais tarde.';
    }
  }
}
