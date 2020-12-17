import 'package:clock/clock.dart';
import 'package:curimba/enums/time_definitions.dart';
import 'package:curimba/extensions/time_values.dart';
import 'package:curimba/utils/masks.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CardModel {
  int id;
  int usersId;
  String lastNumbers;
  String brandName;
  String expiryDate;
  String invoiceDate;

  String get formattedLastNumbers =>
      Masks.lastNumbersMask.maskText(lastNumbers);

  String _getInvoiceDate(String expiryDate, Clock clock) {
    var now = clock.now();
    var formatter = DateFormat('MM/dd');
    // If already passed the expiration day, we count from the next month
    if (int.parse(expiryDate) < now.day) {
      now = now.add(new Duration(days: TimeDefinitions.Month.days));
    }
    final month = now.month.toString();
    final expiryDateWithMonth = month + '/' + expiryDate;
    var tempDate = formatter.parse(expiryDateWithMonth);
    tempDate = tempDate.subtract(new Duration(days: TimeDefinitions.Week.days));
    return formatter.format(tempDate);
  }

  CardModel({
    @required String lastNumbers,
    @required String brandName,
    @required String expiryDate,
    int usersId,
    int id,
    Clock clock,
  }) {
    this.id = id;
    this.usersId = usersId;
    this.lastNumbers = lastNumbers;
    this.brandName = brandName;
    this.expiryDate = expiryDate;
    this.invoiceDate = _getInvoiceDate(expiryDate, clock ?? Clock());
  }

  int getId(){
    return this.id;
  }

  int getUsersId(){
    return this.usersId;
  } 

  String getLastNumbers(){
    return this.lastNumbers;
  }

  String getBrandName(){
    return this.brandName;
  }

  String getExpiryDate(){
    return this.expiryDate;
  }

  String getInvoiceDate(){
    return this.invoiceDate;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'users_id': usersId,
      'last_numbers': lastNumbers,
      'brand_name': brandName,
      'expiry_date': expiryDate,
    };
  }
}
