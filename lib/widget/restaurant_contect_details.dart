import 'package:flutter/material.dart';
import 'package:foody_consumer/models/restaurant.dart';

class RestaurantContactDetails extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantContactDetails({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          restaurant.address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Colors.black.withOpacity(.7)),
        ),
        Text(
          '·',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          restaurant.city,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Colors.black.withOpacity(.7)),
        ),
        Text(
          '·',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          restaurant.phone,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: Colors.black.withOpacity(.7)),
        ),
      ],
    );
  }
}
