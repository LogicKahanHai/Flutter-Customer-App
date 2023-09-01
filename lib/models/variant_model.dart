// ignore_for_file: public_member_api_docs, sort_constructors_first
class VariantModel {
  String id;
  int productId;
  int productVariantId;
  num regPrice;
  num salePrice;
  String variantName;
  String variantValue;
  String variantSKU;
  VariantModel({
    required this.id,
    required this.productId,
    required this.productVariantId,
    required this.regPrice,
    required this.salePrice,
    required this.variantName,
    required this.variantValue,
    required this.variantSKU,
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
      : id = json['_id'] as String,
        productId = json['productId'] as int,
        productVariantId = json['productVariantId'] as int,
        regPrice = json['price'] as num,
        salePrice = json['salePrice'] as num,
        variantName = json['name'] as String,
        variantSKU = json['sku'] as String,
        variantValue = json['name'] as String;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'productId': productId,
        'productVariantId': productVariantId,
        'price': regPrice,
        'salePrice': salePrice,
        'name': variantName,
        'sku': variantSKU,
      };
}
