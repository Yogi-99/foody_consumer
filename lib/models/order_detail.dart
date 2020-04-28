import 'package:foody_consumer/models/meal.dart';

class OrderDetail {
  final String orderId;
  final String quantity;
  final String subTotal;
  final Meal meal;
  final String restaurantName;

  OrderDetail({
    this.orderId,
    this.quantity,
    this.subTotal,
    this.meal,
    this.restaurantName,
  });

  factory OrderDetail.fromJson(Map data) {
    return OrderDetail(
      orderId: data['order_id'],
      meal: Meal.fromJson(data['meal']),
      quantity: data['quantity'],
      subTotal: data['sub_total'],
      restaurantName: data['restaurant_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'quantity': quantity,
      'sub_total': subTotal,
      'restaurant_name': restaurantName,
      'meal': meal.toJson(),
    };
  }
}
