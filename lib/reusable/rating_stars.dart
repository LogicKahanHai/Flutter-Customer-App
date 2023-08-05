import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;
  const RatingStars(
      {Key? key, required this.rating, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        rating > 0 && rating < 1
            ? Icon(
                size: size,
                Icons.star_half_rounded,
                color: color,
              )
            : Icon(
                size: size,
                Icons.star_rate_rounded,
                color: rating >= 1 && rating <= 5
                    ? color
                    : const Color(0xffC4C4C4),
              ),
        rating <= 1 || rating >= 2
            ? Icon(
                size: size,
                Icons.star_rate_rounded,
                color: (rating > 1 || rating >= 2) && rating <= 5
                    ? color
                    : const Color(0xffC4C4C4),
              )
            : rating > 1 && rating < 2
                ? Icon(
                    size: size,
                    Icons.star_half_rounded,
                    color: color,
                  )
                : const SizedBox(
                    height: 0,
                  ),
        rating <= 2 || rating >= 3
            ? Icon(
                size: size,
                Icons.star_rate_rounded,
                color: (rating > 2 || rating >= 3) && rating <= 5
                    ? color
                    : const Color(0xffC4C4C4),
              )
            : rating > 2 && rating < 3
                ? Icon(
                    size: size,
                    Icons.star_half_rounded,
                    color: color,
                  )
                : const SizedBox(
                    height: 0,
                  ),
        rating <= 3 || rating >= 4
            ? Icon(
                size: size,
                Icons.star_rate_rounded,
                color: (rating > 3 || rating >= 4) && rating <= 5
                    ? color
                    : const Color(0xffC4C4C4),
              )
            : rating > 3 && rating < 4
                ? Icon(
                    size: size,
                    Icons.star_half_rounded,
                    color: color,
                  )
                : const SizedBox(
                    height: 0,
                  ),
        rating <= 4 || rating >= 5
            ? Icon(
                size: size,
                Icons.star_rate_rounded,
                color: rating == 5 ? color : const Color(0xffC4C4C4),
              )
            : rating > 4 && rating < 5
                ? Icon(
                    size: size,
                    Icons.star_half_rounded,
                    color: color,
                  )
                : const SizedBox(
                    height: 0,
                  ),
      ],
    );
  }
}
