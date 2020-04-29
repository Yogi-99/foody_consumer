import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody_consumer/global/database_fields.dart';
import 'package:foody_consumer/models/meal.dart';
import 'package:foody_consumer/models/order.dart';
import 'package:foody_consumer/models/order_detail.dart';
import 'package:foody_consumer/models/restaurant.dart';

class RestaurantService {
  final Firestore _db = Firestore.instance;

  Future<List<Restaurant>> getRestaurants() async {
    List<Restaurant> restaurants = [];
    try {
      QuerySnapshot querySnapshot =
          await _db.collection(RESTAURANT_COLLECTION).getDocuments();
      querySnapshot.documents.forEach((res) {
        restaurants.add(Restaurant.fromJson(res.data));
      });
      return restaurants;
    } catch (e) {
      print('getRestaurants: error: ${e.toString()}');
    }
  }

  Future<List<Meal>> getMeals(Restaurant restaurant) async {
    List<Meal> meals = [];
    DocumentSnapshot documentSnapshot =
        await _db.collection(MEALS_COLLECTION).document(restaurant.id).get();

    List dummyData = documentSnapshot.data['meals'];
    dummyData.forEach((f) {
      meals.add(Meal.fromJson(f));
    });
    return meals;
  }

  placeOrder(Order order) {
    List<OrderDetail> dummyData = order.orderDetails;
    List meals = [];

    dummyData.forEach((f) {
      meals.add(f.toJson());
    });

    _db.collection(ORDERS_COLLECTION).document(order.restaurant.id).setData(
      {
        "orders": FieldValue.arrayUnion([order.toJson()]),
        // "id": order.id,
        // "created_at": order.createdAt,
        // 'restaurant': order.restaurant.toJson(),
        // 'user': order.user.toJson(),
        // 'status': order.status,
        // 'total_amount': order.totalAmount,
      },
    );

    print('placeOrder(): Completed');
  }
}
