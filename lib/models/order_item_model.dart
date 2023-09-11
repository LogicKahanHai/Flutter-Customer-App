import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

class OrderItemModel {
  String? name;
  int? productId;
  int? productVariantId;
  int? quantity;
  double? subTotal;
  double? subTotalTax;
  double? total;
  double? totalTax;
  String? sku;
  String? id;
  double? price;

  OrderItemModel({
    this.name,
    this.productId,
    this.productVariantId,
    this.quantity,
    this.subTotal,
    this.subTotalTax,
    this.total,
    this.totalTax,
    this.sku,
    this.id,
    this.price,
  });

  OrderItemModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        productId = json['product_id'] as int,
        productVariantId = json['variation_id'] as int,
        quantity = json['quantity'] as int,
        subTotal = double.tryParse(json['subtotal'] as String? ?? '0.0'),
        subTotalTax = double.tryParse(json['subtotal_tax'] as String? ?? '0.0'),
        total = double.tryParse(json['total'] as String? ?? '0.0'),
        totalTax = double.tryParse(json['total_tax'] as String? ?? '0.0'),
        sku = json['sku'] as String,
        id = json['_id'] as String,
        price = double.tryParse((json['price']).toString());

  Map<String, dynamic> toJson() => {
        'name': name,
        'productId': productId,
        'productVariantId': productVariantId,
        'quantity': quantity,
        'subTotal': subTotal,
        'subTotalTax': subTotalTax,
        'total': total,
        'totalTax': totalTax,
        'sku': sku,
        'id': id,
        'price': price,
      };

  Map<String, dynamic> createOrder() => {
        'qty': quantity,
        'sku': sku,
      };

  OrderItemModel.fromCartItemModel(CartItemModel cartItemModel)
      : name = cartItemModel.productName,
        productId = cartItemModel.productId,
        productVariantId = cartItemModel.variantId,
        quantity = cartItemModel.quantity,
        subTotal = cartItemModel.salePrice,
        subTotalTax = 0.0,
        total = cartItemModel.salePrice,
        totalTax = 0.0,
        sku = ProductRepo.variants
            .firstWhere((element) =>
                element.productVariantId == cartItemModel.variantId)
            .variantSKU,
        id = ProductRepo.variants
            .firstWhere((element) =>
                element.productVariantId == cartItemModel.variantId)
            .id,
        price = cartItemModel.salePrice;
}
