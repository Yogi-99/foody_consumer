import 'package:flutter/material.dart';
import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/screens/meals_screen.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final int index;
  const RestaurantCard({
    @required this.restaurant,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              height: 240,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black.withOpacity(.1),
              ),
            ),
          ),
          Positioned(
            top: 3,
            left: 2,
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(.2),
              ),
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MealsScreen(
                            restaurant: restaurant,
                          ))),
              child: Container(
                height: 135,
                width: 135,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(restaurant.image),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 30,
            child: Container(
              width: 150,
              child: Text(
                restaurant.name,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Colors.black.withOpacity(.7)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 25,
            child: Container(
                width: 150,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Colors.redAccent,
                    ),
                    Text(
                      restaurant.city,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
