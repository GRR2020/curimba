import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CardModel {
  int id;
  int usersId;
  String lastNumbers;
  String brandName;
  String expiryDate;
  String invoiceDate;
  Clock clock;

  String _getInvoiceDate(String expiryDate) {
    var now = clock.now();
    // If already passed the expiration day, we count from the next month
    if (int.parse(expiryDate) < now.day) {
      now = now.add(new Duration(days: 30));
    }
    var formatter = DateFormat('MM/dd');
    String month = now.month.toString();
    String expiryDateWithMonth = month + '/' + expiryDate;
    var tempDate = formatter.parse(expiryDateWithMonth);
    tempDate = tempDate.subtract(new Duration(days: 7));
    return formatter.format(tempDate);
  }

  CardModel({
    @required String lastNumbers,
    @required String brandName,
    @required String expiryDate,
    @required int usersId,
    int id,
    Clock clock,
  }) {
    this.id = id;
    this.usersId = usersId;
    this.lastNumbers = lastNumbers;
    this.brandName = brandName;
    this.expiryDate = expiryDate;
    this.clock = clock ?? Clock();
    this.invoiceDate = _getInvoiceDate(expiryDate);
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
