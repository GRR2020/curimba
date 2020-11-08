import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/locator.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/view_models/sign_in_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_user_repository.dart';

void main() {
  group('SignInViewModel tests', () {
    setUpAll(() {
      setUpLocator();
      SharedPreferences.setMockInitialValues({});
    });

    test('when user is not found, should return UserNotFound code', () async {
      final mockRepository = MockUserRepository();
      final viewModel = SignInViewModel(repository: mockRepository);

      when(mockRepository.findByUsername(any))
          .thenAnswer(((_) => new Future(() => [])));
      final savedUserId = await viewModel.login('username', 'password');
      expect(savedUserId, equals(SignInUpErrors.UserNotFound.code));
    });

    test(
        'when user is found but password mismatch, should return PasswordMismatch code',
        () async {
      final mockRepository = MockUserRepository();
      final viewModel = SignInViewModel(repository: mockRepository);

      when(mockRepository.findByUsername(any))
          .thenAnswer(((_) => new Future(() => [
                UserModel(
                  id: 1,
                  name: 'Nome',
                  username: 'username',
                  password: 'senha',
                )
              ])));
      final savedUserId = await viewModel.login('username', 'password');
      expect(savedUserId, equals(SignInUpErrors.PasswordMismatch.code));
    });

    test('when user is found and password match, should return user id',
        () async {
      final mockRepository = MockUserRepository();
      final viewModel = SignInViewModel(repository: mockRepository);

      when(mockRepository.findByUsername(any))
          .thenAnswer(((_) => new Future(() => [
                UserModel(
                  id: 1,
                  name: 'Nome',
                  username: 'username',
                  password: 'password',
                )
              ])));
      final savedUserId = await viewModel.login('username', 'password');
      expect(savedUserId, equals(1));
    });
  });
}
