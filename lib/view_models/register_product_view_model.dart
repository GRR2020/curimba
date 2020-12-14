import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/product_model.dart';
import 'package:curimba/repositories/product_repository.dart';
import 'package:curimba/utils/locator.dart';
import 'package:flutter/foundation.dart';

import 'base_view_model.dart';

class RegisterProductViewModel extends BaseViewModel {
  @protected
  final ProductRepository repository;

  RegisterProductViewModel({this.repository = const ProductRepository()});

  Future<int> register(ProductModel model) async {
    setViewState(ViewState.Busy);

    final userId = await locator<SharedPreferencesHelper>().userId;
    if (userId <= 0) {
      return -1;
    }

    model.usersId = userId;
    final savedProductId = await repository.insert(model);
    if (savedProductId <= 0) {
      return -1;
    }
    setViewState(ViewState.Idle);
    return savedProductId;
  }
}
