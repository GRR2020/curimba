import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedPreferencesHelper tests', () {
    group('userId', () {
      test('should return userId, when userId present', () async {
        final expectedUserId = 1;

        SharedPreferences.setMockInitialValues({'userId': expectedUserId});
        final userId = await SharedPreferencesHelper().userId;

        expect(userId, expectedUserId);
      });

      test('should return 0, when userId not present', () async {
        final expectedUserId = 0;
        final userId = await SharedPreferencesHelper().userId;

        expect(userId, expectedUserId);
      });
    });
    group('setUserId', () {
      test('should return set user id', () async {
        final expectedUserId = 1;
        await SharedPreferencesHelper().setUserId(expectedUserId);
        final userId = await SharedPreferencesHelper().userId;

        expect(userId, expectedUserId);
      });
    });
    group('deleteUserId', () {
      test('should return delete user id', () async {
        final expectedUserId = 0;
        SharedPreferences.setMockInitialValues({'userId': 1});
        await SharedPreferencesHelper().deleteUserId();
        final userId = await SharedPreferencesHelper().userId;

        expect(userId, expectedUserId);
      });
    });
  });
}
