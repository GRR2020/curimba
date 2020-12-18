import 'package:curimba/enums/view_state.dart';

extension ViewStateExtensions on ViewState {
  bool get isBusy => this == ViewState.Busy;
  bool get isIdle => this == ViewState.Idle;
}