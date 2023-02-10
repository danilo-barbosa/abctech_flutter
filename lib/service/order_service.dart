
import 'package:abc_tech_app/provider/order_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/order.dart';

abstract class OrderServiceInterface { 
  Future<bool> createOrder(Order order);
}

class OrderService extends GetxService implements OrderServiceInterface {
  final OrderProviderInterface _provider;
  
  OrderService(this._provider);
  
  @override
  Future<bool> createOrder(Order order) async {
    Response response = await _provider.postOrder(order);
    if (response.hasError) {
      return Future.error(ErrorDescription("Connection Error."));
    }
    try {
      return Future.sync(() => true);
    } catch (e) {
      return Future.error(ErrorDescription("Unexpected Error."));
    }
  }

}