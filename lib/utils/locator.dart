import 'package:curimba/helpers/notifications_helper.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/helpers/time_helper.dart';
import 'package:curimba/utils/navigation_service.dart';
import 'package:curimba/view_models/create_card_view_model.dart';
import 'package:curimba/view_models/home_view_model.dart';
import 'package:curimba/view_models/list_cards_view_model.dart';
import 'package:curimba/view_models/recommended_cards_view_model.dart';
import 'package:curimba/view_models/register_product_view_model.dart';
import 'package:curimba/view_models/sign_in_view_model.dart';
import 'package:curimba/view_models/sign_up_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SharedPreferencesHelper());
  locator.registerLazySingleton(() => NotificationsHelper());
  locator.registerLazySingleton(() => TimeHelper());
  locator.registerFactory(() => ListCardsViewModel());
  locator.registerFactory(() => RecommendedCardsViewModel());
  locator.registerFactory(() => RegisterProductViewModel());
  locator.registerFactory(() => CreateCardViewModel());
  locator.registerFactory(() => SignInViewModel());
  locator.registerFactory(() => SignUpViewModel());
  locator.registerFactory(() => HomeViewModel());
}

