import 'dart:convert';

import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/repo_constants.dart';
import 'package:pk_customer_app/models/models.dart';

class ProductRepo {
  static late List<ProductModel> _products;
  static late List<VariantModel> _variants;
  static late List<CategoryModel> _categories;

  static const String _baseUrl = RepoConstants.baseUrl;

  static List<ProductModel> get products => _products;

  static List<VariantModel> get variants => _variants;

  static List<CategoryModel> get categories => _categories;

  static set _setProducts(List<ProductModel> products) {
    try {
      _products.clear();
    } catch (e) {
      _products = [];
    }
    _products.addAll(products);
  }

  static set _setVariants(List<VariantModel> variants) {
    try {
      _variants.clear();
    } catch (e) {
      _variants = [];
    }
    _variants.addAll(variants);
  }

  static set _setCategories(List<CategoryModel> categories) {
    try {
      _categories.clear();
    } catch (e) {
      _categories = [];
    }
    _categories.addAll(categories);
  }

  static Future<List<dynamic>> getProductsVariantsAndCategories() async {
    const String categoryApiCall =
        '$_baseUrl/ms/customer/mobile/category/getCategory';
    const String productApiCall =
        '$_baseUrl/ms/customer/mobile/product/getProduct';
    const String variantApiCall =
        '$_baseUrl/ms/customer/mobile/productVariant/getProductVariant';

    final categoryResponse = await RepoConstants.sendRequest(
        categoryApiCall, null, null, RequestType.get);
    if (jsonDecode(categoryResponse.body)['statusCode'] != 200) {
      return [false, HomeLoadedFailureType.categories];
    }
    final List<dynamic> categoriesJson =
        jsonDecode(categoryResponse.body)['data'];
    List<CategoryModel> categories = [];
    for (var category in categoriesJson) {
      categories.add(CategoryModel.fromJson(category));
    }
    _setCategories = categories;
    final productResponse = await RepoConstants.sendRequest(
        productApiCall, null, null, RequestType.get);
    if (jsonDecode(productResponse.body)['statusCode'] != 200) {
      return [false, HomeLoadedFailureType.products];
    }
    final List<dynamic> productsJson = jsonDecode(productResponse.body)['data'];
    List<ProductModel> products = [];
    for (var product in productsJson) {
      products.add(ProductModel.fromJson(product));
    }
    _setProducts = products;
    final variantResponse = await RepoConstants.sendRequest(
        variantApiCall, null, null, RequestType.get);
    if (jsonDecode(variantResponse.body)['statusCode'] != 200) {
      return [false, HomeLoadedFailureType.variants];
    }
    final List<dynamic> variantsJson = jsonDecode(variantResponse.body)['data'];
    List<VariantModel> variants = [];
    for (var variant in variantsJson) {
      try {
        variants.add(VariantModel.fromJson(variant));
      } catch (e) {
        print(e);
      }
    }
    _setVariants = variants;
    Set<ProductModel> finalProducts = {};
    for (var product in products) {
      for (var variant in variants) {
        if (variant.productId == product.productId) {
          final newProduct = product.copyWith(
            selectedVariant: variant.productVariantId,
          );
          final index = finalProducts.toList().indexWhere(
                (element) => element.productId == newProduct.productId,
              );
          if (index == -1) {
            finalProducts.add(newProduct);
          } else {
            continue;
          }
        }
      }
    }
    _setProducts = finalProducts.toList();
    return [true, null];
  }

  static int get productCount {
    try {
      return _products.length;
    } catch (e) {
      return _products.length;
    }
  }

  static ProductModel getProductById(int productId) {
    return _products.firstWhere((element) => element.productId == productId);
  }

  static VariantModel getVariantById(int productId, int variantId) {
    try {
      return _variants.firstWhere((element) =>
          element.productId == productId &&
          element.productVariantId == variantId);
    } catch (e) {
      return _variants.firstWhere(
        (element) => element.productId == productId,
      );
    }
  }

  static int getDiscount(int productId, int variantId, int quantity) {
    try {
      final variant = _variants.firstWhere((element) =>
          element.productId == productId &&
          element.productVariantId == variantId);
      return (((variant.regPrice * quantity) - (variant.salePrice * quantity)) /
              (variant.regPrice * quantity) *
              100)
          .round();
    } catch (e) {
      return 0;
    }
  }

  static bool updateSelectedVariant(int productId, int variantId) {
    try {
      _products = _products.map((e) {
        if (e.productId == productId) {
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
}
