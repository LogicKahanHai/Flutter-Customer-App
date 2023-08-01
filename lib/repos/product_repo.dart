import 'package:pk_customer_app/models/models.dart';

class ProductRepo {
  ProductRepo();

  static late List<ProductModel> _products;
  static late List<VariantModel> _variants;

  static get products => _products;

  static get variants => _variants;

  set setProducts(List<ProductModel> products) {
    _products.addAll(products);
  }

  set setVariants(List<VariantModel> variants) {
    _variants.addAll(variants);
  }

  Future<void> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    _products = [
      ProductModel(
        id: '1',
        name: 'Laddoos',
        description: 'description',
        image: 'assets/images/products/chakli.png',
        selectedVariant: '',
        rating: 4.6,
      ),
      ProductModel(
        id: '2',
        name: 'Chakli',
        description: 'description',
        image: 'assets/images/products/chakli.png',
        selectedVariant: '',
        rating: 4.8,
      ),
      ProductModel(
        id: '3',
        name: 'Modak',
        description: 'description',
        image: 'assets/images/products/chakli.png',
        selectedVariant: '',
        rating: 4.9,
      ),
    ];

    _variants = [
      VariantModel(
        id: '400',
        productId: '1',
        regPrice: 150,
        salePrice: 100,
        key: '400',
        value: '400 g',
      ),
      VariantModel(
        id: '500',
        productId: '1',
        regPrice: 250,
        salePrice: 200,
        key: '500',
        value: '500 g',
      ),
      VariantModel(
        id: '600',
        productId: '1',
        regPrice: 350,
        salePrice: 300,
        key: '600',
        value: '600 g',
      ),
      VariantModel(
        id: '700',
        productId: '1',
        regPrice: 450,
        salePrice: 400,
        key: '700',
        value: '700 g',
      ),
      VariantModel(
        id: '400',
        productId: '2',
        regPrice: 150,
        salePrice: 100,
        key: '400',
        value: '400 g',
      ),
      VariantModel(
        id: '500',
        productId: '2',
        regPrice: 250,
        salePrice: 200,
        key: '500',
        value: '500 g',
      ),
      VariantModel(
        id: '600',
        productId: '2',
        regPrice: 350,
        salePrice: 300,
        key: '600',
        value: '600 g',
      ),
      VariantModel(
        id: '400',
        productId: '3',
        regPrice: 150,
        salePrice: 100,
        key: '400',
        value: '400 g',
      ),
      VariantModel(
        id: '500',
        productId: '3',
        regPrice: 250,
        salePrice: 200,
        key: '500',
        value: '500 g',
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
    try {

      return _variants.firstWhere(
          (element) => element.productId == id && element.id == variantId);
    } catch (e) {
      return _variants.firstWhere(
        (element) => element.productId == id,
      );
    }
  }

  static bool updateSelectedVariant(String id, String variantId) {
    try {
      _products = _products.map((e) {
        if (e.id == id) {
          return e.copyWith(selectedVariant: variantId);
        } else {
          return e;
        }
      }).toList();
      return true;
    } catch (e) {
      return false;
    }
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
