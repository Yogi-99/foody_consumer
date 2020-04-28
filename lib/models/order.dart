import 'package:foody_consumer/models/order_detail.dart';
import 'package:foody_consumer/models/restaurant.dart';
import 'package:foody_consumer/models/user.dart';

class Order {
  final String id;
  final Restaurant restaurant;
  final String status;
  final User user;
  final List<OrderDetail> orderDetails;
  final String totalAmount;
  final String createdAt;

  Order({
    this.id,
    this.restaurant,
    this.status,
    this.orderDetails,
    this.user,
    this.totalAmount,
    this.createdAt,
  });

  factory Order.fromJson(Map data) {
    return Order(
      id: data['id'],
      restaurant: Restaurant.fromJson(data['restaurant']),
      status: data['status'],
      user: User.fromJson(data['user']),
      totalAmount: data['total_amount'],
      createdAt: data['created_at'],
      orderDetails: (data['order_details'] as List ?? [])
          .map((o) => OrderDetail.fromJson(o))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant': restaurant.toJson(),
      'status': status,
      'user': user.toJson(),
      'total_amount': totalAmount,
      'created_at': createdAt,
      'order_details': orderDetails.map((f) => f.toJson()).toList(),
    };
  }
}
