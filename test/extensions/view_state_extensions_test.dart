import 'package:curimba/enums/view_state.dart';
import 'package:curimba/extensions/view_state_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ViewStateExtensions tests', () {
    group('isIdle', () {
      test('should return true, when view state is idle', () {
        final viewState = ViewState.Idle;
        expect(viewState.isIdle, true);
      });
      test('should return false, when view state is not idle', () {
        final viewState = ViewState.Busy;
        expect(viewState.isIdle, false);
      });
    });

    group('isBusy', () {
      test('should return true, when view state is busy', () {
        final viewState = ViewState.Busy;
        expect(viewState.isBusy, true);
      });
      test('should return false, when view state is not busy', () {
        final viewState = ViewState.Idle;
        expect(viewState.isBusy, false);
      });
    });
  });
}
