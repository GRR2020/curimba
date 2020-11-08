import 'package:curimba/navigation_service.dart';
import 'package:curimba/view_models/sign_in_view_model.dart';
import 'package:curimba/view_models/sign_up_view_model.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SharedPreferencesHelper());

  locator.registerFactory(() => CardViewModel());
  locator.registerFactory(() => SignInViewModel());
  locator.registerFactory(() => SignUpViewModel());
}