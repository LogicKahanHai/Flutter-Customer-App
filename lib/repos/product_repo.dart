import 'package:flutter/material.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

class ProductRepo extends ChangeNotifier {
  static List<ProductModel> _productList = [
    ProductModel(
      id: '1',
      name: 'Laddoos',
      description: 'description',
      image: 'assets/images/products/chakli.png',
      price: 100,
      variants: const [
        {'400': '400 g'},
        {'500': '500 g'},
        {'600': '600 g'}
      ],
      selectedVariant: '400',
      rating: 4.6,
      isInCart: false,
    ),
    ProductModel(
      id: '2',
      name: 'Chakli',
      description: 'description',
      image: 'assets/images/products/chakli.png',
      price: 200,
      variants: const [
        {'400': '400 g'},
        {'500': '500 g'},
        {'600': '600 g'},
        {'700': '700 g'}
      ],
      selectedVariant: '400',
      rating: 4.8,
      isInCart: false,
    ),
    ProductModel(
      id: '3',
      name: 'Modak',
      description: 'description',
      image: 'assets/images/products/chakli.png',
      price: 100,
      variants: const [
        {'400': '400 g'},
        {'500': '500 g'}
      ],
      selectedVariant: '400',
      rating: 4.7,
      isInCart: false,
    ),
  ];

  static List<ProductModel> get getProducts => _productList;

  static set setProducts(List<ProductModel> products) {
    _productList = products;
  }

  static int get productCount => _productList.length;

  static ProductModel getProductById(String id) {
    return _productList.firstWhere((element) => element.id == id);
  }

  static bool isProductInCart(String id) {
    return _productList.firstWhere((element) => element.id == id).isInCart;
  }

  static bool updateSelectedVariant(String id, String variant) {
    _productList = _productList.map((e) {
      if (e.id == id) {
        return e.copyWith(selectedVariant: variant);
      } else {
        return e;
      }
    }).toList();
    return true;
  }

  static void addToCart(String id) {
    _productList.where((element) => element.id == id).first.isInCart = true;
  }

  static void removeFromCart(String id) {
    _productList.where((element) => element.id == id).first.isInCart = false;
  }

  static void updateProducts() {
    print('Updating Products');
    final List<ProductModel> cartList = cartState.products;
    _productList.forEach((element) {
      if (cartList.contains(element)) {
        element.isInCart = true;
      } else {
        element.isInCart = false;
      }
    });
    for (var element in _productList) {
      print(element.isInCart);
    }
  }
}
