// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price; //[ ]: Every variant has different price
  final List<Map<String, String>> variants; //[ ]: New model for variants
  final String selectedVariant;
  final double rating;
  bool isInCart;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.variants,
    required this.selectedVariant,
    required this.rating,
    this.isInCart = false,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    double? price,
    List<Map<String, String>>? variants,
    String? selectedVariant,
    double? rating,
    bool? isInCart,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      variants: variants ?? this.variants,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      rating: rating ?? this.rating,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'variants': variants,
      'selectedVariant': selectedVariant,
      'rating': rating,
      'isInCart': isInCart,
    };
  }

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        description = json['description'] as String,
        image = json['image'] as String,
        price = json['price'] as double,
        variants = (json['variants'] as List<dynamic>)
            .map((e) => Map<String, String>.from(e as Map))
            .toList(),
        selectedVariant = json['selectedVariant'] as String,
        rating = json['rating'] as double,
        isInCart = json['isInCart'] as bool;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProductModel && other.id == id;
      
  @override
  int get hashCode => id.hashCode;
      
}
