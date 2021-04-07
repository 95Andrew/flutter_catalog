import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  final double rating;
  final bool isIgnorePointer;
  final Function(double) onRatingUpdate;

  const CustomRatingBar({Key key, @required this.rating, this.isIgnorePointer = true, this.onRatingUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIgnorePointer
        ? IgnorePointer(
            child: RatingBar.builder(
              initialRating: rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                return null;
              },
            ),
          )
        : RatingBar.builder(
            initialRating: rating,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (val)=> onRatingUpdate(val)
          );
  }
}
