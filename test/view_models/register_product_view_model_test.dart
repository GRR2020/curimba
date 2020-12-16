import 'package:curimba/models/product_model.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/register_product_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_product_repository.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({'userId': 1});
  });

  group('RegisterProductViewModel tests', () {
    test('should return product id, when product is successfully registered',
        () async {
      final mockRepository = MockProductRepository();
      when(mockRepository.insert(any)).thenAnswer((_) => new Future(() => 1));

      final viewModel = RegisterProductViewModel(repository: mockRepository);

      final savedCardId = await viewModel.registerProduct(ProductModel(
        name: 'name',
        description: 'description',
        price: 10,
      ));
      expect(savedCardId, 1);
    });

    test('should return error code, when it fails to register product',
        () async {
      final mockRepository = MockProductRepository();
      when(mockRepository.insert(any)).thenAnswer((_) => new Future(() => 0));

      final viewModel = RegisterProductViewModel(repository: mockRepository);

      final savedCardId = await viewModel.registerProduct(ProductModel(
        name: 'name',
        description: 'description',
        price: 10,
      ));
      expect(savedCardId, -1);
    });
  });
}
