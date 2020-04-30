import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foody_consumer/models/meal.dart';
import 'package:foody_consumer/models/order_detail.dart';
import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/models/user.dart';
import 'package:foody_consumer/providers/order_provider.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/screens/cart_screen.dart';
import 'package:foody_consumer/services/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PlaceOrderBottomSheet extends StatefulWidget {
  final Meal meal;
  final Restaurant restaurant;

  const PlaceOrderBottomSheet({
    @required this.meal,
    @required this.restaurant,
  });

  @override
  _PlaceOrderBottomSheetState createState() => _PlaceOrderBottomSheetState();
}

class _PlaceOrderBottomSheetState extends State<PlaceOrderBottomSheet> {
  int quantiy = 0;
  User _currentUser;
  RestaurantService _restaurantService = RestaurantService();

  _showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 18.0,
      backgroundColor: Colors.red,
      textColor: Colors.black,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  void initState() {
    super.initState();
    _currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .9,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: size.height * .4,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                image: DecorationImage(
                  image: NetworkImage(widget.meal.image),
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        widget.meal.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                    ),
                    Container(
                      height: 35.0,
                      width: 35.0,
                      child: widget.meal.foodType == 'Non Veg'
                          ? Image(
                              image: AssetImage(
                                  'assets/food_mark/non_veg_food_mark.png'))
                          : SvgPicture.asset(
                              'assets/food_mark/veg_food_mark.svg'),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.meal.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Colors.black.withOpacity(.5), fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: RichText(
                            text: TextSpan(
                                style: Theme.of(context).textTheme.title,
                                children: [
                          TextSpan(
                              text: 'Amount: ',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.8))),
                          TextSpan(
                              text: widget.meal.price,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          TextSpan(text: ' Rs'),
                        ]))),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            size: 30.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          RichText(
                              text: TextSpan(
                                  style: Theme.of(context).textTheme.subhead,
                                  children: [
                                TextSpan(
                                  text: '${widget.meal.cookTime}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 30.0),
                                ),
                                TextSpan(
                                  text: ' mins',
                                )
                              ])),
                          SizedBox(
                            width: 20.0,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Quantity',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.black.withOpacity(.8)),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (quantiy <= 0) {
                              _showMessage("Quantity already at zero.");
                            } else {
                              setState(() {
                                quantiy--;
                              });
                            }
                          },
                          child: Icon(Icons.remove),
                        ),
                        Text(
                          '$quantiy',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        ),
                        FlatButton(
                          onPressed: () {
                            if (quantiy >= 15) {
                              _showMessage(
                                  'Sorry, You can not order more than 15 quantiy at a time.');
                            } else {
                              setState(() {
                                quantiy++;
                              });
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          // Spacer(),
          Consumer<OrderProvider>(
            builder: (context, orderData, child) {
              return Container(
                padding: EdgeInsets.all(12.0),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 50,
                      color: Color(0xFF0D1333).withOpacity(.2),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFEDEE),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CartScreen(
                                      restaurant: widget.restaurant))),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.red,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          bool _isPresent = false;
                          bool _differentRestaurant = false;
                          Uuid uuid = Uuid();
                          String orderId = uuid.v1();
                          OrderDetail orderDetail = OrderDetail(
                            orderId: orderId,
                            meal: widget.meal,
                            restaurantName: widget.restaurant.name,
                            quantity: quantiy.toString(),
                            subTotal:
                                '${_calculateTotal(int.parse(widget.meal.price), quantiy)}',
                          );
                          if (quantiy <= 0) {
                            _showMessage('You need to add at least one item.');
                            print('quantiy less than 0');
                            return;
                          }

                          if (orderData.orderDetails.length == 0) {
                            orderData.addOrderDetails(orderDetail);
                            _showMessage(
                                'Item successfully added in the cart.');
                            print('Meal successfully added');
                            return;
                          }

                          List<OrderDetail> orderDetails =
                              orderData.orderDetails;

                          orderDetails.forEach(
                            (orderDetailIterator) {
                              if (orderDetailIterator.meal.name ==
                                  orderDetail.meal.name) {
                                _showMessage('Meal already in the cart');
                                print('meal already in cart');
                                _isPresent = true;
                                return;
                              }
                            },
                          );

                          if (orderDetails.length > 0) {
                            if (orderDetails[0].restaurantName !=
                                orderDetail.restaurantName) {
                              _showMessage('Meal from different restaurant');
                              print('meal from different restaurant');
                              return;
                            }
                          }

                          if (!_isPresent) {
                            orderData.addOrderDetails(orderDetail);
                            _showMessage(
                                'Item successfully added in the cart.');
                            print('outside item successfully added');
                          }
                          if (_differentRestaurant) {
                            _showMessage(
                                'You can not add meals from different restaurant at the same time.');
                            print('different restuarnt ');
                          }

                          // _restaurantService.placeOrder(order);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              "Total: ${_calculateTotal(int.parse(widget.meal.price), quantiy)}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

int _calculateTotal(int amount, int quantiy) {
  return amount * quantiy;
}
