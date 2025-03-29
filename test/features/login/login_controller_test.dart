import 'package:despesas_app/common/models/user_model.dart';
import 'package:despesas_app/features/login/login_controller.dart';
import 'package:despesas_app/features/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late MockSecureStorageService mockSecureStorageService;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late MockGraphQLService mockGraphQLService;
  late LoginController loginController;
  late UserModel user;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorageService = MockSecureStorageService();
    mockGraphQLService = MockGraphQLService();

    loginController = LoginController(
      authService: mockFirebaseAuthService,
      secureStorageService: mockSecureStorageService,
      graphQLService: mockGraphQLService,
    );

    user = UserModel(
      name: 'User',
      email: 'user@email.com',
      id: '1a2b3c4d5e',
    );
  });

  group('Tests Sign In Controller State', () {
  test('Should update state to SignInStateSuccess', () async {
    expect(loginController.state, isInstanceOf<LoginStateInitial>());

    when(() => mockSecureStorageService.write(
          key: "CURRENT_USER",
          value: user.toJson(),
        )).thenAnswer((_) async {});

    when(
      () => mockFirebaseAuthService.login(
        email: 'user@email.com',
        password: 'user@123',
      ),
    ).thenAnswer(
      (_) async => user,
    );

    await loginController.login(
      email: 'user@email.com',
      password: 'user@123',
    );
    expect(loginController.state, isInstanceOf<LoginStateSuccess>());
  });

  test('Should update state to SignInStateError', () async {
    expect(loginController.state, isInstanceOf<LoginStateInitial>());

    when(
      () => mockSecureStorageService.write(
        key: "CURRENT_USER",
        value: user.toJson(),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockFirebaseAuthService.login(
        email: 'user@email.com',
        password: 'user@123',
      ),
    ).thenThrow(
      Exception(),
    );

    await loginController.login(
      email: 'user@email.com',
      password: 'user@123',
    );
    expect(loginController.state, isInstanceOf<LoginStateError>());
  });
});
}