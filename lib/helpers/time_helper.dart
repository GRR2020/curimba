import 'package:clock/clock.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeHelper {
  Clock clock;

  TimeHelper({
    Clock clock,
  }) {
    this.clock = clock ?? Clock();
  }

  void setup({String locale: 'America/Sao_Paulo'}) {
    tz.initializeTimeZones();
    var sp = tz.getLocation(locale);
    tz.setLocalLocation(sp);
  }

  tz.TZDateTime nextInstanceOfTenAM() {
    DateTime clockNow = clock.now();
    final tz.TZDateTime now = tz.TZDateTime.from(clockNow, tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.monday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}