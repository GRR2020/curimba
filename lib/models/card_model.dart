import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class CardModel {
  int id;
  String lastNumbers;
  String brandName;
  String expiryDate;
  String invoiceDate;
  bool isTesting;

  String _getInvoiceDate(String expiryDate) {
    var now = DateTime.now();
    if (isTesting) {
      now = DateTime.parse("2020-10-23 20:18:04");
    }
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
    int id,
    bool isTesting,
  }) {
    this.id = id;
    this.lastNumbers = lastNumbers;
    this.brandName = brandName;
    this.expiryDate = expiryDate;
    isTesting = isTesting ?? false;
    this.isTesting = isTesting;
    this.invoiceDate = _getInvoiceDate(expiryDate);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'last_numbers': lastNumbers,
      'brand_name': brandName,
      'expiry_date': expiryDate,
    };
  }


}
