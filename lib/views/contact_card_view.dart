import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_contact_app/pages/home/home_controller.dart';
import '../models/contact_model.dart';
import '../pages/detail/detail_controller.dart';
import '../pages/detail/detail_page.dart';
import '../services/log_service.dart';
import '../services/network_service.dart';

class ContactCardView extends StatelessWidget {
  final Contact contact;
  final DetailController detailController = Get.find<DetailController>();
  final HomeController homeController = Get.find<HomeController>();

  ContactCardView({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("This widget id: ${contact.id} build");
    return Card(
      child: ListTile(
        onTap: () {
          detailController.getData(contact, DetailState.read);
          Get.to(() => const DetailPage());
        },
        title: Text(contact.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(contact.phoneNumber, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                await NetworkService.DELETE(NetworkService.API_POST_DELETE, contact.id);
                await homeController.getDataFromNetwork();
                LogService.i("Pressed Contact: ${contact.id} delete");
              },
              icon: const Icon(Icons.delete_outline),
            ),
            IconButton(
              onPressed: () {
                LogService.v("Pressed Contact: ${contact.id} update");
                detailController.getData(contact, DetailState.edit);
                Get.to(() => const DetailPage());
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
