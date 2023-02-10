

import 'package:abc_tech_app/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/assist.dart';

class OrderPage extends GetView<OrderController> {
  
  const OrderPage({Key? key}) : super(key: key);

  Widget _renderAssists(List<Assist> assists) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: assists.length,
      itemBuilder: (context, index) => 
        ListTile(title: Text(assists[index].name)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title:  const Text("Order Form")),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView (
          child: Form(
            key:controller.formKey, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                Row(
                  children: const [Expanded(
                    child: Text(
                      "Fill in the order form",
                      textAlign: TextAlign.center, 
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ))]
                ),
                TextFormField(
                  controller: controller.operatorIdController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Service Provider Code"),
                  textAlign: TextAlign.center                  
                ),
                Row(
                  children: [
                    const Expanded(
                      child: 
                    Padding(padding: EdgeInsets.only(top: 25, bottom: 25),
                    child: Text(
                      "Select assistances to be performed.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                      )
                      )),
                    Ink(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Colors.orange),
                      width: 40,
                      height: 40,
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () => controller.selectAssits()),
                    )  
                  ],),
                  Obx(() => _renderAssists(controller.selectedAssists)),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.finishStartOrder,
                          child: const Text("Finish")))
                    ]
                  )
              
          ],))
        ),
      )

    );
  }


  
}