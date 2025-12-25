import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/order.dart';

class OrderProvider extends StateNotifier<List<Order>> {
  OrderProvider() : super([]);// at which type object mangage statenotifier same type here initialize

  // set the state
  void setOrders(List<Order> orders) {
    state = orders;
  }
}

final orderProvider =
    StateNotifierProvider<OrderProvider, List<Order>>((ref) => OrderProvider());
