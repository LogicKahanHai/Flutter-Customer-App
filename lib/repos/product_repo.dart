import 'package:pk_customer_app/models/models.dart';

class ProductRepo {
  ProductRepo() {
    getProducts();
  }

  static late List<ProductModel> _products;
  static late List<VariantModel> _variants;
  static late List<ReviewModel> _reviews;

  static List<ProductModel> get products => _products;

  static List<VariantModel> get variants => _variants;

  static List<ReviewModel> get reviews => _reviews;

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
        name: 'Chakli',
        description: 'description',
        image: 'assets/images/products/chakli.png',
        selectedVariant: '',
        rating: 4.6,
      ),
      ProductModel(
        id: '2',
        name: 'Modak',
        description: 'description',
        image: 'assets/images/products/modak.png',
        selectedVariant: '',
        rating: 4.8,
      ),
      ProductModel(
        id: '3',
        name: 'Chivda',
        description: 'description',
        image: 'assets/images/products/chivda.png',
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

    _reviews = [
      ReviewModel(
        productId: 'xyz',
        name: 'Sakshi',
        title: 'Amazing taste',
        rating: 4.5,
        image: 'https://placehold.co/150',
      ),
      ReviewModel(
        productId: 'xyz',
        name: 'Sakshi',
        title: 'Woww!!',
        review:
            'I ordered chakli and it tasted just like my dadi’s. Can’t get over it. You must try it!',
        rating: 4.5,
        image: 'https://placehold.co/150',
      ),
      ReviewModel(
        productId: 'xyz',
        name: 'Naveen',
        title: 'Amazing taste',
        review:
            'I ordered chakli and it tasted just like my dadi’s. I\'m a hosteller',
        rating: 4.5,
      ),
      ReviewModel(
        productId: 'xyz',
        name: 'Uma',
        title: 'Amazing taste',
        review:
            'Do quis cupidatat duis cupidatat laborum ex dolor consequat quis voluptate ex.',
        rating: 4.5,
        image: 'https://placehold.co/150',
      ),
      ReviewModel(
        productId: 'xyz',
        name: 'Ankita',
        rating: 4.5,
        review: 'Wow! Loved it.',
        image: 'https://placehold.co/150',
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

  static int getDiscount(String id, String variantId) {
    try {
      final variant = _variants.firstWhere(
          (element) => element.productId == id && element.id == variantId);
      return ((variant.regPrice - variant.salePrice) / variant.regPrice * 100)
          .round();
    } catch (e) {
      return 0;
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
