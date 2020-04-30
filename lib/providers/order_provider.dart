import 'package:flutter/foundation.dart';
import 'package:foody_consumer/models/order_detail.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderDetail> _orderDetails = [];

  List<OrderDetail> get orderDetails => _orderDetails;

  addOrderDetails(OrderDetail orderDetail) {
    _orderDetails.add(orderDetail);
    notifyListeners();
  }

  deleteItemFromCart(OrderDetail orderDetail) {
    _orderDetails.removeWhere((od) => orderDetail.meal.name == od.meal.name);
    notifyListeners();
  }
}
