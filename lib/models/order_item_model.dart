// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

class OrderItemModel {
  final String id;
  final String productId;
  final String variantId;
  final int quantity;
  final double price;
  final String name;
  OrderItemModel({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.quantity,
    required this.price,
    required this.name,
  });

  OrderItemModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'] as String,
        productId = json['productId'] as String,
        variantId = json['variantId'] as String,
        quantity = json['quantity'] as int,
        price = json['price'] as double,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'variantId': variantId,
        'quantity': quantity,
        'price': price,
        'name': name,
      };

  OrderItemModel.fromCartItem(CartItemModel cartItemModel)
      : id = cartItemModel.id,
        productId = cartItemModel.productId,
        variantId = cartItemModel.variantId,
        quantity = cartItemModel.quantity,
        price = cartItemModel.salePrice,
        name = cartItemModel.productName;

  static List<OrderItemModel> dummyList() {
    final variants = [
      VariantModel(
        id: '400',
        productId: '1',
        regPrice: 150,
        salePrice: 100,
        variantName: '400',
        variantValue: '400 g',
      ),
      VariantModel(
        id: '500',
        productId: '1',
        regPrice: 250,
        salePrice: 200,
        variantName: '500',
        variantValue: '500 g',
      ),
      VariantModel(
        id: '600',
        productId: '1',
        regPrice: 350,
        salePrice: 300,
        variantName: '600',
        variantValue: '600 g',
      ),
      VariantModel(
        id: '700',
        productId: '1',
        regPrice: 450,
        salePrice: 400,
        variantName: '700',
        variantValue: '700 g',
      ),
      VariantModel(
        id: '5',
        productId: '4',
        regPrice: 150,
        salePrice: 100,
        variantName: '5',
        variantValue: 'Pack of 5 pieces',
      ),
      VariantModel(
        id: '10',
        productId: '4',
        regPrice: 250,
        salePrice: 200,
        variantName: '10',
        variantValue: 'Pack of 10 pieces',
      ),
      VariantModel(
        id: '15',
        productId: '4',
        regPrice: 350,
        salePrice: 300,
        variantName: '15',
        variantValue: 'Pack of 15 pieces',
      ),
      VariantModel(
        id: '20',
        productId: '4',
        regPrice: 450,
        salePrice: 400,
        variantName: '20',
        variantValue: 'Pack of 20 pieces',
      ),
      VariantModel(
        id: '400',
        productId: '2',
        regPrice: 150,
        salePrice: 100,
        variantName: '400',
        variantValue: '400 g',
      ),
      VariantModel(
        id: '500',
        productId: '2',
        regPrice: 250,
        salePrice: 200,
        variantName: '500',
        variantValue: '500 g',
      ),
      VariantModel(
        id: '600',
        productId: '2',
        regPrice: 350,
        salePrice: 300,
        variantName: '600',
        variantValue: '600 g',
      ),
      VariantModel(
        id: '400',
        productId: '3',
        regPrice: 150,
        salePrice: 100,
        variantName: '400',
        variantValue: '400 g',
      ),
      VariantModel(
        id: '500',
        productId: '3',
        regPrice: 250,
        salePrice: 200,
        variantName: '500',
        variantValue: '500 g',
      ),
    ];
    return [
      OrderItemModel(
        id: '1',
        productId: '1',
        variantId:
            variants.firstWhere((element) => element.productId == '1').id,
        quantity: 1,
        price: 100,
        name: ProductRepo.products
            .firstWhere((element) => element.id == '1')
            .name,
      ),
      OrderItemModel(
        id: '2',
        productId: '2',
        variantId:
            variants.firstWhere((element) => element.productId == '2').id,
        quantity: 2,
        price: 200,
        name: ProductRepo.products
            .firstWhere((element) => element.id == '2')
            .name,
      ),
      OrderItemModel(
        id: '3',
        productId: '3',
        variantId:
            variants.firstWhere((element) => element.productId == '3').id,
        quantity: 3,
        price: 300,
        name: ProductRepo.products
            .firstWhere((element) => element.id == '3')
            .name,
      ),
    ];
  }
}
