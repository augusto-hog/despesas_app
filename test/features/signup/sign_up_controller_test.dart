import 'package:despesas_app/common/models/user_model.dart';
import 'package:despesas_app/features/cadastro/sign_up_controller.dart';
import 'package:despesas_app/features/cadastro/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late SignUpController signUpController;
  late MockSecureStorageService mockSecureStorageService;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late MockGraphQLService mockGraphQLService;
  late UserModel user;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorageService = MockSecureStorageService();
    mockGraphQLService = MockGraphQLService();

    signUpController = SignUpController(
        authService: mockFirebaseAuthService,
        secureStorage: mockSecureStorageService,
        graphQLService: mockGraphQLService);

    user = UserModel(
      name: 'User',
      email: 'user@email.com',
      id: '1a2b3c4d5e',
    );
  });

  test('Tests Sign Up Controller Success', () async {
    expect(signUpController.state, isInstanceOf<SignUpInitialState>());

    when(() => mockGraphQLService.init()).thenAnswer((_) async {});

    when(() => mockSecureStorageService.write(
          key: "CURRENT_USER",
          value: user.toJson(),
        )).thenAnswer((_) async {});

    when(
      () => mockFirebaseAuthService.signUp(
        name: 'User',
        email: 'user@email.com',
        password: 'user@123',
      ),
    ).thenAnswer(
      (_) async => user,
    );

    await signUpController.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    );

    expect(signUpController.state, isInstanceOf<SignUpSuccessState>());
  });

  test('Tests Sign Up Controller Failed', () async {
    expect(signUpController.state, isInstanceOf<SignUpInitialState>());

    when(() => mockSecureStorageService.write(
          key: "CURRENT_USER",
          value: user.toJson(),
        )).thenAnswer((_) async {});

    when(() => mockFirebaseAuthService.signUp(
          name: 'User',
          email: 'user@email.com',
          password: 'user@123',
        )).thenThrow(
      Exception(),
    );

    await signUpController.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    );

    expect(signUpController.state, isInstanceOf<SignUpErrorState>());
  });
}
