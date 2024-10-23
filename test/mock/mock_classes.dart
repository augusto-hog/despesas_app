import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}