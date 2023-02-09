
import 'package:abc_tech_app/controller/assists_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/assist.dart';

class HomePage extends GetView<AssistsController> {

  const HomePage({Key? key}) : super(key: key);

  Widget _renderList(List<Assist>? assists) {
    if (assists == null) {
      return Container();
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: assists.length,
      itemBuilder: (context, index) => ListTile(title: Text(assists[index].name))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test")),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Row(children: const [
                Expanded(child: Text("The available services are:", textAlign: TextAlign.center))
              ]),
              Row(children: [
                Expanded(child: TextButton(
                  onPressed: controller.getAsssistList, 
                  child: const Text("Reload"))),
              ]),
              controller.obx((state) => _renderList(state), onLoading: const Text("No services available."), onError: (error) => Text(error.toString()))
            ],
          ),
        ),
      ),
    );
  }

  



}