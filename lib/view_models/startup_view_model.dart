import 'package:curimba/view_models/base_model.dart';
import 'package:curimba/services/push_notification_service.dart';
import 'package:curimba/locator.dart';

class StartUpViewModel extends BaseModel {
  final PushNotificationService _pushNotificationService =
  locator<PushNotificationService>();

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
  }
}