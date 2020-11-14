import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/locator.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/view_models/sign_up_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_user_repository.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({});
  });

  group('SignUpViewModel tests', () {
    test('when username is found, should return UserFound code', () async {
      final mockRepository = MockUserRepository();
      final viewModel = SignUpViewModel(repository: mockRepository);

      when(mockRepository.findByUsername(any))
          .thenAnswer(((_) => new Future(() => [
                UserModel(
                  id: 1,
                  name: 'Nome',
                  username: 'username',
                  password: 'senha',
                )
              ])));

      final savedUserId = await viewModel.register(UserModel(
        name: 'Nome',
        username: 'username',
        password: 'senha',
      ));
      expect(savedUserId, equals(SignInUpErrors.UserFound.code));
    });

    test('when username is not found, should return new user id', () async {
      final mockRepository = MockUserRepository();
      final viewModel = SignUpViewModel(repository: mockRepository);

      when(mockRepository.findByUsername(any))
          .thenAnswer(((_) => new Future(() => [])));
      when(mockRepository.insert(any)).thenAnswer(((_) => new Future(() => 1)));

      final savedUserId = await viewModel.register(UserModel(
        name: 'Nome',
        username: 'username',
        password: 'senha',
      ));
      expect(savedUserId, equals(1));
    });
  });
}
