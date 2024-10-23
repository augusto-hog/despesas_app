import 'package:despesas_app/common/models/user_model.dart';
import 'package:despesas_app/services/auth_service.dart';
import 'package:despesas_app/services/secure_storage.dart';
import 'package:mocktail/mocktail.dart';

// Mock Models

class MockUser extends Mock implements UserModel {}

// Mock Services
class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}