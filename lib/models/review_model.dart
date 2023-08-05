// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReviewModel {
  final String name;
  final String productId;
  final String title;
  final String review;
  final String image;
  final double rating;

  ReviewModel({
    required this.name,
    required this.productId,
    this.title = '',
    this.review = '',
    this.image = '',
    required this.rating,
  });
}
