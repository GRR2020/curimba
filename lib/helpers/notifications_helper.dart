import 'package:curimba/models/card_model.dart';
import 'package:curimba/utils/locator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
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

  initScheduleRecommendCards() {
    locator<RecommendedCardsViewModel>().initialize();
    CardModel recommendedCard = locator<RecommendedCardsViewModel>().cards[0];
    _scheduleWeeklyMondayTenAMNotification(recommendedCard);
  }

  Future<void> _scheduleWeeklyMondayTenAMNotification(CardModel card) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Recomendação de cartão',
        "O cartão recomendado da semana é o ${card.brandName} com números ${card.formattedLastNumbers}",
        _nextInstanceOfMondayTenAM(),
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

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.monday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}