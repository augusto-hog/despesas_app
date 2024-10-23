import 'package:despesas_app/common/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_classes.dart';

void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    user = UserModel(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    );
  });

  group('Tests Signup', (){
    test('Test Signup Success', () async {
    when(() => mockFirebaseAuthService.signUp(
          name: 'User',
          email: 'user@email.com',
          password: 'user@123',
        )).thenAnswer(
      (_) async => user,
    );
    final result = await mockFirebaseAuthService.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    );

    expect(result, user);
  });

  test('Test Signup Failed', () async {
    when(() => mockFirebaseAuthService.signUp(
          name: 'User',
          email: 'user@email.com',
          password: 'user@123',
        )).thenThrow(
      Exception(),
    );
    

    expect(
      () => mockFirebaseAuthService.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    ), throwsException);
  });
  });
}
