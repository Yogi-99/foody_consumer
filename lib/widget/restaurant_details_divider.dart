import 'package:flutter/material.dart';

class RestaurantDetailsDivider extends StatelessWidget {
  final String rating;
  final String time;
  final String price;

  const RestaurantDetailsDivider({Key key, this.rating, this.time, this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.red,
            ),
            Text(
              rating,
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.access_time,
              color: Colors.red,
            ),
            Text(
              '$time mins',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.attach_money,
              color: Colors.red,
            ),
            Text(
              '$price/-',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
