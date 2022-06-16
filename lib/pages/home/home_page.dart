import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_contact_app/views/contact_card_view.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contacts"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Stack(
            children: [
              // #body
              ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return ContactCardView(contact: controller.items[index]);
                  }),

              // #indicator
              Visibility(
                visible: controller.isLoading,
                child: const Center(child: CircularProgressIndicator()),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: homeController.createPost,
        child: const Icon(Icons.add),
      ),
    );
  }
}
