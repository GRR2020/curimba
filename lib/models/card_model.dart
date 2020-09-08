class CardModel {
  final int id;
  final String lastNumbers;
  final String brandName;
  final String expiryDate;

  CardModel({this.id ,this.lastNumbers, this.brandName, this.expiryDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'last_numbers': lastNumbers,
      'brand_name': brandName,
      'expiry_date': expiryDate,
    };
  }
}