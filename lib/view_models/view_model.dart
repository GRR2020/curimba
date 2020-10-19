import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/repositories/repository.dart';
import 'package:flutter/widgets.dart';

abstract class ViewModel extends ChangeNotifier {
  init() async {
    await refreshAllStates();
  }

  @protected
  refreshAllStates();
}