import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeHelper {

  void setup() {
    tz.initializeTimeZones();
    var sp = tz.getLocation('America/Sao_Paulo');
    tz.setLocalLocation(sp);
  }

  tz.TZDateTime nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
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