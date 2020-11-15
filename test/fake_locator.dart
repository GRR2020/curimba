import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/utils/navigation_service.dart';
import 'package:get_it/get_it.dart';

import 'mocks/mock_card_view_model.dart';
import 'mocks/mock_sign_in_view_model.dart';
import 'mocks/mock_sign_up_view_model.dart';

GetIt fakeLocator = GetIt.I;

void setUpFakeLocator() {
  fakeLocator.registerLazySingleton(() => NavigationService());
  fakeLocator.registerLazySingleton(() => SharedPreferencesHelper());
  fakeLocator.registerFactory(() => MockCardViewModel());
  fakeLocator.registerFactory(() => MockSignInViewModel());
  fakeLocator.registerFactory(() => MockSignUpViewModel());
}
