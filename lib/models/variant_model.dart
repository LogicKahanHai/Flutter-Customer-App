// ignore_for_file: public_member_api_docs, sort_constructors_first
class VariantModel {
  String id;
  String productId;
  double regPrice;
  double salePrice;
  String variantName;
  String variantValue;
  VariantModel({
    required this.id,
    required this.productId,
    required this.regPrice,
    required this.salePrice,
    required this.variantName,
    required this.variantValue,
  });

  @override
  bool operator ==(covariant VariantModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.regPrice == regPrice &&
        other.salePrice == salePrice &&
        other.variantName == variantName &&
        other.variantValue == variantValue;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        regPrice.hashCode ^
        salePrice.hashCode ^
        variantName.hashCode ^
        variantValue.hashCode;
  }

  VariantModel.fromJson(Map<String, dynamic> json)
      : id = json['productVariantId'] as String,
        productId = json['productId'] as String,
        regPrice = json['price'] as double,
        salePrice = json['salePrice'] as double,
        variantName = json['name'] as String,
        variantValue = json['weight'] as num < 1000
            ? '${json['weight']} gm'
            : '${json['weight'] / 1000} kg';

  Map<String, dynamic> toJson() => {
        'productVariantId': id,
        'productId': productId,
        'price': regPrice,
        'salePrice': salePrice,
        'name': variantName,
        'weight': variantValue,
      };
}
