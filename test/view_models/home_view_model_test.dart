import 'package:curimba/models/user_model.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mocks/mock_user_repository.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({'receiveNotifications': 0, 'usersId': 1});
  });

  tearDownAll((){
    SharedPreferences.setMockInitialValues({'receiveNotifications': 0, 'usersId': 1});
  });

  group('HomeViewModel tests', () {
    test('should return receive notifications on initialize', () async {
      final viewModel = HomeViewModel();

      await viewModel.initialize();
      final receiveNotifications = viewModel.receiveNotifications;
      expect(receiveNotifications, 0);
    });

    test('should return updated receive notifications on turn on', () async {
      final mockRepository = MockUserRepository();
      when(mockRepository.findById(any)).thenAnswer((_) => new Future(() => [UserModel(name: 'name', username: 'username', password: '123456', receiveNotifications: 0)]));
      when(mockRepository.update(any)).thenAnswer((_) => new Future(() => 1));

      final viewModel = HomeViewModel(repository: mockRepository, sendNotifications: false);
      await viewModel.initialize();
      await viewModel.handleNotifications();
      final receiveNotifications = viewModel.receiveNotifications;
      expect(receiveNotifications, 1);
    });
  });
}
