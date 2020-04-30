import 'package:flutter/material.dart';
import 'package:foody_consumer/models/meal.dart';
import 'package:foody_consumer/models/restaurant.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final Function onClick;
  final Restaurant restaurant;
  const MealCard({
    @required this.meal,
    @required this.restaurant,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black.withOpacity(.7),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(meal.image),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  meal.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 40.0,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                            color: Colors.red.withOpacity(.7)),
                        child: Center(
                            child: Text(
                          'Order Now',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
