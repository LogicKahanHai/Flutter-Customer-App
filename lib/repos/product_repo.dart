import 'package:pk_customer_app/models/models.dart';

class ProductRepo {
  static late List<ProductModel> _products;

  ProductRepo();

  static get products => _products;

  set setProducts(List<ProductModel> products) {
    _products.addAll(products);
  }

  Future<void> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    _products = [
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
  }

  static int get productCount {
    try {
      return _products.length;
    } catch (e) {
      ProductRepo().getProducts();
      return _products.length;
    }
  }

  static ProductModel getProductById(String id) {
    return _products.firstWhere((element) => element.id == id);
  }

  static bool isProductInCart(String id) {
    return _products.firstWhere((element) => element.id == id).isInCart;
  }

  static bool updateSelectedVariant(String id, String variant) {
    _products = _products.map((e) {
      if (e.id == id) {
        return e.copyWith(selectedVariant: variant);
      } else {
        return e;
      }
    }).toList();
    return true;
  }

  static void addToCart(String id) {
    final index = _products.indexWhere((element) => element.id == id);
    _products[index].isInCart = true;
  }

  static void removeFromCart(String id) {
    final index = _products.indexWhere((element) => element.id == id);
    _products[index].isInCart = false;
  }

  // static void updateProducts() {
  //   print('Updating Products');
  //   final List<ProductModel> cartList = cartState.products;
  //   _products.forEach((element) {
  //     if (cartList.contains(element)) {
  //       element.isInCart = true;
  //     } else {
  //       element.isInCart = false;
  //     }
  //   });
  //   for (var element in _products) {
  //     print(element.isInCart);
  //   }
  // }
}
