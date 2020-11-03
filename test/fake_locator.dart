import 'package:curimba/navigation_service.dart';
import 'package:curimba/shared_preferences_helper.dart';
import 'package:curimba/view_models/sign_up_view_model.dart';
import 'package:get_it/get_it.dart';

import 'mocks.dart';

GetIt fakeLocator = GetIt.I;

void setUpFakeLocator() {
  fakeLocator.registerLazySingleton(() => NavigationService());
  fakeLocator.registerLazySingleton(() => SharedPreferencesHelper());
  fakeLocator.registerFactory(() => MockCardViewModel());
  fakeLocator.registerFactory(() => MockSignInViewModel());
  fakeLocator.registerFactory(() => SignUpViewModel());
}
