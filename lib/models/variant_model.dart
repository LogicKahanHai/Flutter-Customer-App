// ignore_for_file: public_member_api_docs, sort_constructors_first
class VariantModel {
  String id;
  double regPrice;
  double salePrice;
  String key;
  String value;
  VariantModel({
    required this.id,
    required this.regPrice,
    required this.salePrice,
    required this.key,
    required this.value,
  });

  @override
  bool operator ==(covariant VariantModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.regPrice == regPrice &&
        other.salePrice == salePrice &&
        other.key == key &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        regPrice.hashCode ^
        salePrice.hashCode ^
        key.hashCode ^
        value.hashCode;
  }

  VariantModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        regPrice = json['regPrice'] as double,
        salePrice = json['salePrice'] as double,
        key = json['key'] as String,
        value = json['value'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'regPrice': regPrice,
        'salePrice': salePrice,
        'key': key,
        'value': value,
      };
}
