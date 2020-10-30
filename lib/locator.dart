import 'package:curimba/navigation_service.dart';
import 'package:curimba/screens/sign_up_view_model.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:curimba/view_models/user_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserViewModel());
  locator.registerLazySingleton(() => CardViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
}