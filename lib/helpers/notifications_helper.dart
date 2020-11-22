import 'package:curimba/helpers/time_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/utils/locator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:curimba/view_models/recommended_cards_view_model.dart';

class NotificationsHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  init() {
    AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  initScheduleRecommendCards() async {
    CardModel recommendedCard = await locator<RecommendedCardsViewModel>().getFirstCard();
    if (recommendedCard != null) {
      _scheduleWeeklyMondayTenAMNotification(recommendedCard);
    }
  }

  Future<void> _scheduleWeeklyMondayTenAMNotification(CardModel card) async {
    locator<TimeHelper>().setup();
    String title = 'O cartão recomendado da semana é:';
    String body =  "${card.brandName} com números ${card.formattedLastNumbers}";
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        locator<TimeHelper>().nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}