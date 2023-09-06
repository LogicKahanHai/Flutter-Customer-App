// ignore_for_file: public_member_api_docs, sort_constructors_first

class CreateOrderItemModel {
  final String variantSKU;
  final int variantId;
  final int quantity;
  final double price;
  CreateOrderItemModel({
    required this.variantSKU,
    required this.variantId,
    required this.quantity,
    required this.price,
  });

  CreateOrderItemModel.fromJSON(Map<String, dynamic> json)
      : variantId = json['variantId'] as int,
        quantity = json['quantity'] as int,
        price = json['price'] as double,
        variantSKU = json['variantSKU'] as String;

  Map<String, dynamic> toJson() => {
        'itemId': variantId,
        'sku': variantSKU,
        'qty': quantity,
        'price': price,
      };
}
