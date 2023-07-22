import 'package:pk_customer_app/models/models.dart';

class ProducRepo {
  static List<ProductModel> productList = [
    const ProductModel(
      id: '1',
      name: 'Laddoos',
      description: 'description',
      image: 'assets/images/products/chakli.png',
      price: 100,
      variants: [
        {'400': '400 g'},
        {'500': '500 g'},
        {'600': '600 g'}
      ],
      quantity: 1,
      isInCart: false,
    ),
    const ProductModel(
      id: '2',
      name: 'Chakli',
      description: 'description',
      image: 'assets/images/products/chakli.png',
      price: 200,
      variants: [
        {'400': '400 g'},
        {'500': '500 g'},
        {'600': '600 g'},
        {'700': '700 g'}
      ],
      quantity: 1,
      isInCart: false,
    ),
    const ProductModel(
      id: '3',
      name: 'Modak',
      description: 'description',
      image: 'assets/images/products/chakli.png',
      price: 100,
      variants: [
        {'400': '400 g'},
        {'500': '500 g'}
      ],
      quantity: 1,
      isInCart: false,
    ),
  ];

  static List<ProductModel> get getProducts => productList;

  static set setProducts(List<ProductModel> products) {
    productList = products;
  }

  static ProductModel getProductById(String id) {
    return productList.firstWhere((element) => element.id == id);
  }

  static bool isProductInCart(String id) {
    return productList.firstWhere((element) => element.id == id).isInCart;
  }

  static void addToCart(String id) {
    productList = productList.map((e) {
      if (e.id == id) {
        return e.copyWith(isInCart: true);
      } else {
        return e;
      }
    }).toList();
  }

  static void removeFromCart(String id) {
    productList = productList.map((e) {
      if (e.id == id && e.isInCart) {
        return e.copyWith(isInCart: false);
      } else {
        return e;
      }
    }).toList();
  }
}
