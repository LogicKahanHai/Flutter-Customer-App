// ignore_for_file: public_member_api_docs, sort_constructors_first
class VariantModel {
  String id;
  String productId;
  double regPrice;
  double salePrice;
  String key;
  String value;
  VariantModel({
    required this.id,
    required this.productId,
    required this.regPrice,
    required this.salePrice,
    required this.key,
    required this.value,
  });

  @override
  bool operator ==(covariant VariantModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.regPrice == regPrice &&
        other.salePrice == salePrice &&
        other.key == key &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        regPrice.hashCode ^
        salePrice.hashCode ^
        key.hashCode ^
        value.hashCode;
  }

  VariantModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        productId = json['productId'] as String,
        regPrice = json['regPrice'] as double,
        salePrice = json['salePrice'] as double,
        key = json['key'] as String,
        value = json['value'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'regPrice': regPrice,
        'salePrice': salePrice,
        'key': key,
        'value': value,
      };
}
