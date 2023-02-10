
import 'package:get/get_connect.dart';

import '../constants.dart';
import '../model/order.dart';

abstract class OrderProviderInterface {
  Future<Response> postOrder(Order order);
}

class OrderProvider extends GetConnect implements OrderProviderInterface {
  @override
  Future<Response> postOrder(order) => 
    post('${Constants.url}/order', order.toMap());

}
