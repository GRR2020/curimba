import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'locator.dart';
import 'models/card_model.dart';

class NotificationWorkHelper {
  init() async {
    final cardViewModel = locator<CardViewModel>();
    await cardViewModel.init();
    List<CardModel> invoiceCards = cardViewModel.invoiceCards;

    Workmanager.initialize(
        callbackDispatcher,
        isInDebugMode: true
    );
    Workmanager.registerPeriodicTask(
      "invoiceCards",
      "showNotificationForInvoiceCardsTask",
      frequency: Duration(minutes: 15),
      inputData: <String, dynamic>{
        'invoiceCards': invoiceCards,
      },
    );
  }

  void callbackDispatcher() {
    Workmanager.executeTask((task, inputData) {

      FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

      var android = new AndroidInitializationSettings('app_icon');
      var iOS = new IOSInitializationSettings();

      var settings = new InitializationSettings(android: android, iOS: iOS);
      flip.initialize(settings);
      _showNotificationWithDefaultSound(flip, inputData);
      return Future.value(true);
    });
  }

  Future _showNotificationWithDefaultSound(flip, inputData) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'ID do canal',
        'Nome do canal',
        'Descrição do canal',
        importance: Importance.max,
        priority: Priority.high
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );
    List<CardModel> invoiceCards = inputData['invoiceCards'];
    bool shouldSendNotification = false;
    String invoiceCardsName = '';
    invoiceCards.forEach((card) {
      var now = DateTime.now();
      int invoiceMonth = int.parse(card.invoiceDate.substring(0, 2));
      int invoiceDay = int.parse(card.invoiceDate.substring(3, 5));
      var invoiceDate = new DateTime(now.year, invoiceMonth, invoiceDay);
      var isSameDate = now.year == invoiceDate.year && now.month == invoiceDate.month && now.day == invoiceDate.day;
      if (isSameDate) {
        shouldSendNotification = true;
        invoiceCardsName += card.lastNumbers + ' ';
      }
    });
    if (shouldSendNotification) {
      await flip.show(0, 'Semana do vencimento',
          'Essa é a melhor semana para você usar os cartões $invoiceCardsName',
          platformChannelSpecifics, payload: ''
      );
    }
  }
}