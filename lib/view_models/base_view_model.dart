import 'package:curimba/enums/view_state.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  @protected
  refreshAllStates() {
    notifyListeners();
  }

  setViewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }
}
