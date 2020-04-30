import 'package:flutter/material.dart';
import 'package:foody_consumer/models/meal.dart';
import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/services/restaurant.dart';
import 'package:foody_consumer/widget/meal_card.dart';
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
  bool _mealsPresent = true;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
                      showSearch(
                          context: context,
                          delegate: MealSearch(
                              meals: await _restaurantService
                                  .getMeals(widget.restaurant),
                              restaurant: widget.restaurant));
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
                      FutureBuilder(
                        future: _restaurantService.getMeals(widget.restaurant),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Meal>> snapshot) {
                          if (snapshot.hasData) {
                            List<Meal> meals = snapshot.data;
                            return Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 12.0,
                                children: List.generate(meals.length, (index) {
                                  Meal meal = meals[index];
                                  return MealCard(
                                    meal: meal,
                                    restaurant: widget.restaurant,
                                    onClick: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(40.0))),
                                        builder: (context) =>
                                            PlaceOrderBottomSheet(
                                          meal: meal,
                                          restaurant: widget.restaurant,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            );
                          } else {
                            Future.delayed(Duration(seconds: 4), () {
                              setState(() {
                                _mealsPresent = false;
                              });
                            });
                            return Expanded(
                              child: Center(
                                child: _mealsPresent
                                    ? CircularProgressIndicator()
                                    : Text('No Meals Available!'),
                              ),
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

class MealSearch extends SearchDelegate<List<Meal>> {
  final List<Meal> meals;
  final Restaurant restaurant;

  MealSearch({this.meals, this.restaurant});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (meals.isEmpty) {
      return Container(
        child: Center(
          child: Text('No Data'),
        ),
      );
    }
    final suggestions =
        meals.where((r) => r.name.toLowerCase().contains(query.toLowerCase()));
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      children: suggestions
          .map<Container>((m) => Container(
                padding: EdgeInsets.all(4.0),
                child: ListTile(
                  title: Text(m.name),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      m.image,
                      height: 80.0,
                      width: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40.0),
                        ),
                      ),
                      builder: (context) => PlaceOrderBottomSheet(
                        meal: m,
                        restaurant: restaurant,
                      ),
                    );
                  },
                ),
              ))
          .toList(),
    );
  }
}
