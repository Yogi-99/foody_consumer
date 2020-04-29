import 'package:flutter/material.dart';
import 'package:foody_consumer/models/order.dart';
import 'package:foody_consumer/models/order_detail.dart';
import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/models/user.dart';
import 'package:foody_consumer/providers/order_provider.dart';
import 'package:foody_consumer/providers/user.dart';
import 'package:foody_consumer/services/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  static String id = 'cart_screen';
  final Restaurant restaurant;

  const CartScreen({Key key, this.restaurant}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  RestaurantService _restaurantService = RestaurantService();
  User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;
  }

  @override
  Widget build(BuildContext context) {
    List<OrderDetail> _orderDetails =
        Provider.of<OrderProvider>(context, listen: false).orderDetails;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Your Cart',
          style:
              Theme.of(context).textTheme.display1.copyWith(color: Colors.red),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
            size: 30.0,
          ),
        ),
        actions: <Widget>[
          Center(
            child: RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.red),
                  children: [
                    TextSpan(text: 'Items'),
                    TextSpan(text: '(${_orderDetails.length})  '),
                  ]),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _orderDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  OrderDetail orderDetail = _orderDetails[index];
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                height: 100.0,
                                width: 100.0,
                                image: NetworkImage(orderDetail.meal.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      orderDetail.meal.name,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30.0,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  orderDetail.restaurantName,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(.7),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: orderDetail.meal.price,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Rs',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.7),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' x ',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.7),
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: orderDetail.quantity,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Q',
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.7),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Sub Total: ',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                      TextSpan(
                                        text: orderDetail.subTotal,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Rs',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black.withOpacity(.8),
                                        ),
                                      ),
                                    ])),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Have a promo code?',
                        style: TextStyle(color: Colors.red, fontSize: 18.0),
                      ),
                    ),
                    Spacer(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black.withOpacity(.7),
                          fontSize: 26.0,
                        ),
                        children: [
                          TextSpan(text: 'Total: '),
                          TextSpan(
                            text: _getTotalAmount(_orderDetails),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Rs',
                            style: TextStyle(
                                color: Colors.black.withOpacity(.7),
                                fontSize: 16.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _getTotalAmount(_orderDetails);
                  Uuid uuid = Uuid();
                  String orderId = uuid.v1();
                  Order order = Order(
                    id: orderId,
                    createdAt: currentDateTime(),
                    status: 'Ordered',
                    orderDetails: _orderDetails,
                    user: _currentUser,
                    totalAmount: _getTotalAmount(_orderDetails),
                    restaurant: widget.restaurant,
                  );

                  _restaurantService.placeOrder(order);
                },
                child: Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Text(
                      'Place Order',
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String currentDateTime() {
  DateTime _dateTime = DateTime.now();
  return '${_dateTime.hour}:${_dateTime.minute} ${_dateTime.day}-${_dateTime.month}-${_dateTime.year}';
}

String _getTotalAmount(List<OrderDetail> orderDetails) {
  int totalAmount = 0;

  orderDetails.forEach((orderDetail) {
    totalAmount += int.parse(orderDetail.subTotal);
  });
  return totalAmount.toString();
}
