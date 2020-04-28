import 'package:flutter/material.dart';
import 'package:foody_consumer/models/meal.dart';
import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/services/restaurant.dart';
import 'package:foody_consumer/widget/place_order_bottom_sheet.dart';
import 'package:foody_consumer/widget/restaurant_contect_details.dart';
import 'package:foody_consumer/widget/restaurant_details_divider.dart';

var id;

class MealsScreen extends StatefulWidget {
  final Restaurant restaurant;

  MealsScreen({this.restaurant});
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  RestaurantService _restaurantService = RestaurantService();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: widget.restaurant.image,
              child: Image(
                height: size.height * .35,
                width: size.width,
                fit: BoxFit.cover,
                image: NetworkImage(widget.restaurant.image),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      try {
                        List<Meal> meals = await _restaurantService
                            .getMeals(widget.restaurant);
                        print(meals);
                      } catch (e) {
                        print('getMeals(): error: ${e.toString()}');
                      }
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * .75,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45.0)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: size.width * .9,
                        child: Text(
                          widget.restaurant.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(fontSize: 28.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: RestaurantContactDetails(
                          restaurant: widget.restaurant,
                        ),
                      ),
                      Divider(),
                      RestaurantDetailsDivider(
                        price: '200',
                        rating: '4.4',
                        time: '25',
                      ),
                      Divider(
                        color: Colors.red.withOpacity(.7),
                      ),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     'Menu',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headline
                      //         .copyWith(fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      FutureBuilder(
                        future: _restaurantService.getMeals(widget.restaurant),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Meal>> snapshot) {
                          if (snapshot.hasData) {
                            List<Meal> meals = snapshot.data;
                            print('meals : $meals');
                            return Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 12.0,
                                children: List.generate(meals.length, (index) {
                                  Meal meal = meals[index];
                                  return Container(
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.black.withOpacity(.7),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(meal.image))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 2.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withOpacity(.7),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                bottomRight:
                                                    Radius.circular(20.0),
                                                topRight: Radius.circular(5.0),
                                              ),
                                            ),
                                            child: Text(
                                              meal.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          isScrollControlled:
                                                              true,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              40.0))),
                                                          builder: (context) =>
                                                              PlaceOrderBottomSheet(
                                                                meal: meal,
                                                                restaurant: widget
                                                                    .restaurant,
                                                              ));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20.0)),
                                                          color: Colors.red
                                                              .withOpacity(.7)),
                                                      child: Center(
                                                          child: Text(
                                                        'Order Now',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .title
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ));
                                }),
                              ),
                            );
                          } else {
                            return Container(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
