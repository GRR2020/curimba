// Imports the Flutter Driver API.
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Card App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final registerCardFinder = find.byValueKey('register card');
    final listCardsFinder = find.byValueKey('list cards');
    final recommendCardsFinder = find.byValueKey('recommended cards');
    final cardBrandFinder = find.byValueKey('card brand');
    final lastNumbersFinder = find.byValueKey('last numbers');
    final invoiceDateFinder = find.byValueKey('invoice date');
    final submitRegisterCardFinder = find.byValueKey('submit register card');
    final cardTitleFinder = find.byValueKey('card title');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver.waitUntilFirstFrameRasterized();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('register card', () async {
      await driver.tap(registerCardFinder);
      await driver.tap(cardBrandFinder);
      await driver.enterText('Visa');
      await driver.tap(lastNumbersFinder);
      await driver.enterText('4444');
      await driver.tap(invoiceDateFinder);
      await driver.enterText('15');
      await driver.tap(submitRegisterCardFinder);
      await driver.waitFor(find.text('Salvando cartão'));
      await driver.waitFor(find.text('Cartão salvo com sucesso'));
      await driver.tap(find.pageBack());
      await driver.tap(listCardsFinder);
      expect(await driver.getText(cardTitleFinder), 'Visa');
    });
  });
}