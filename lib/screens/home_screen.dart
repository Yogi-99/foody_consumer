import 'package:flutter/material.dart';

import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/screens/meals_screen.dart';
import 'package:foody_consumer/services/restaurant.dart';
import 'package:foody_consumer/widget/navigation_drawer.dart';
import 'package:foody_consumer/widget/restaurant_card.dart';
import 'package:foody_consumer/widget/restaurant_details_divider.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RestaurantService _restaurantService = RestaurantService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.red,
              ),
              onPressed: () async {
                _restaurantService.getRestaurants();
              }),
        ],
        title: RichText(
            text: TextSpan(
                style: Theme.of(context).textTheme.display1,
                children: [
              TextSpan(
                text: 'ABC',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Eats',
                // style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ])),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.restaurant_menu,
              size: 35.0,
              color: Colors.red,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder(
        future: _restaurantService.getRestaurants(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Restaurant>> snapshot) {
          if (snapshot.hasData) {
            List<Restaurant> restaurants = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.headline,
                              children: [
                            TextSpan(
                              text: 'Popular ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0),
                            ),
                            TextSpan(
                              text: 'Restaurants',
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ])),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: size.height * .4,
                        child: ListView.builder(
                          itemCount: restaurants.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            Restaurant restaurant = restaurants[index];
                            return RestaurantCard(
                              index: index,
                              restaurant: restaurant,
                            );
                          },
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context).textTheme.headline,
                              children: [
                            TextSpan(
                              text: 'Nearby ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30.0),
                            ),
                            TextSpan(
                              text: 'Restaurants',
                              // style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ])),
                      _buildRestaurantList(restaurants, context)
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

_buildRestaurantList(List<Restaurant> restaurants, BuildContext context) {
  List<Widget> restaurantList = [];
  restaurants.forEach((Restaurant restaurant) {
    restaurantList.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MealsScreen(
                        restaurant: restaurant,
                      )));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: Colors.grey[200],
            ),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: restaurant.image,
                  child: Image(
                    height: 120.0,
                    width: 120.0,
                    image: NetworkImage(restaurant.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // RatingStars(restaurant.rating),
                      SizedBox(height: 4.0),
                      Text(
                        restaurant.address,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withOpacity(.7),
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        restaurant.city,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(.7)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        color: Colors.red.withOpacity(.7),
                      ),
                      RestaurantDetailsDivider(
                        rating: '4.4',
                        price: '220',
                        time: '36',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
  return Column(children: restaurantList);
}
