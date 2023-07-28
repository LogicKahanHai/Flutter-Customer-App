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
        variants: [
          VariantModel(
            id: '400',
            regPrice: 150,
            salePrice: 100,
            key: '400',
            value: '400 g',
          ),
          VariantModel(
            id: '500',
            regPrice: 150,
            salePrice: 100,
            key: '500',
            value: '500 g',
          ),
          VariantModel(
            id: '600',
            regPrice: 150,
            salePrice: 100,
            key: '600',
            value: '600 g',
          ),
          VariantModel(
            id: '700',
            regPrice: 150,
            salePrice: 100,
            key: '700',
            value: '700 g',
          ),
        ],
        selectedVariant: VariantModel(
          id: '400',
          regPrice: 150,
          salePrice: 100,
          key: '400',
          value: '400 g',
        ),
        rating: 4.6,
      ),
      ProductModel(
        id: '2',
        name: 'Chakli',
        description: 'description',
        image: 'assets/images/products/chakli.png',
        variants: [
          VariantModel(
            id: '400',
            regPrice: 150,
            salePrice: 100,
            key: '400',
            value: '400 g',
          ),
          VariantModel(
            id: '500',
            regPrice: 150,
            salePrice: 100,
            key: '500',
            value: '500 g',
          ),
          VariantModel(
            id: '600',
            regPrice: 150,
            salePrice: 100,
            key: '600',
            value: '600 g',
          ),
        ],
        selectedVariant: VariantModel(
          id: '400',
          regPrice: 150,
          salePrice: 100,
          key: '400',
          value: '400 g',
        ),
        rating: 4.8,
      ),
      ProductModel(
        id: '3',
        name: 'Modak',
        description: 'description',
        image: 'assets/images/products/chakli.png',
        variants: [
          VariantModel(
            id: '400',
            regPrice: 150,
            salePrice: 100,
            key: '400',
            value: '400 g',
          ),
          VariantModel(
            id: '500',
            regPrice: 150,
            salePrice: 100,
            key: '500',
            value: '500 g',
          ),
        ],
        selectedVariant: VariantModel(
          id: '400',
          regPrice: 150,
          salePrice: 100,
          key: '400',
          value: '400 g',
        ),
        rating: 4.7,
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

  static VariantModel getVariantById(String id, String variantId) {
    return _products
        .firstWhere((element) => element.id == id)
        .variants
        .firstWhere((element) => element.id == variantId);
  }

  

  static bool updateSelectedVariant(String id, String variantId) {
    _products = _products.map((e) {
      if (e.id == id) {
        return e.copyWith(selectedVariant: getVariantById(id, variantId));
      } else {
        return e;
      }
    }).toList();
    return true;
  }

  // static void addToCart(String id) {
  //   final index = _products.indexWhere((element) => element.id == id);
  //   _products[index].isInCart = true;
  // }

  // static void removeFromCart(String id) {
  //   final index = _products.indexWhere((element) => element.id == id);
  //   _products[index].isInCart = false;
  // }

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
