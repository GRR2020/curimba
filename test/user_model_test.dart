import 'package:curimba/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel tests', () {
    test('test toMap, should return mapped model', () {
      final userModel = UserModel(
        id: 0,
        name: 'Nome',
        username: 'username',
        password: 'senha',
      );

      final userMap = userModel.toMap();

      expect(userMap['id'], 0);
      expect(userMap['name'], 'Nome');
      expect(userMap['username'], 'username');
      expect(userMap['password'], 'senha');
    });
  });
}
