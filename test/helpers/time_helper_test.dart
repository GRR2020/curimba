import 'package:clock/clock.dart';
import 'package:curimba/helpers/time_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
    var sp = tz.getLocation('America/Sao_Paulo');
    tz.setLocalLocation(sp);
  });

  group('TimeHelper tests', () {
    group('nextInstanceOfTenAM', () {
      test('should be same day when is before ten AM', () async {
        final mockClock = Clock.fixed(DateTime(2020, 10, 23, 9));
        final timeHelper = TimeHelper(clock: mockClock);
        timeHelper.setup();
        var tenAM = timeHelper.nextInstanceOfTenAM();
        tz.TZDateTime expectedTenAm = tz.TZDateTime(tz.local, 2020, 10, 23, 10);

        expect(tenAM, expectedTenAm);
      });
    });
    group('nextInstanceOfMondayTenAM', () {
      test('should be same day when today is monday and before ten AM', () async {
        final mockClock = Clock.fixed(DateTime(2020, 11, 23, 9));
        final timeHelper = TimeHelper(clock: mockClock);
        timeHelper.setup();
        var tenAM = timeHelper.nextInstanceOfMondayTenAM();
        tz.TZDateTime expectedTenAm = tz.TZDateTime(tz.local, 2020, 11, 23, 10);

        expect(tenAM, expectedTenAm);
      });
      test('should be next week when today is not monday and before ten AM', () async {
        final mockClock = Clock.fixed(DateTime(2020, 11, 24, 9));
        final timeHelper = TimeHelper(clock: mockClock);
        timeHelper.setup();
        var tenAM = timeHelper.nextInstanceOfMondayTenAM();
        tz.TZDateTime expectedTenAm = tz.TZDateTime(tz.local, 2020, 11, 30, 10);

        expect(tenAM, expectedTenAm);
      });
    });
  });
}