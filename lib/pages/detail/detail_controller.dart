import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:network_contact_app/models/contact_model.dart';
import '../../services/network_service.dart';
import '../../services/util_service.dart';
import '../home/home_controller.dart';

enum DetailState {read, edit, create}

class DetailController extends GetxController {
  late DetailState state = DetailState.create;
  Contact? contact;
  late TextEditingController titleController = TextEditingController();
  late TextEditingController bodyController = TextEditingController();


  void getData(Contact contact, DetailState state) {
    this.contact = contact;
    this.state = state;
    titleController.text = contact.name;
    bodyController.text = contact.phoneNumber;
    update();
  }

  bool get readOnly {
    return state == DetailState.read;
  }

  void pressedEdit() {
    state = DetailState.edit;
    update();
  }

  void clearOldData() {
    titleController.clear();
    bodyController.clear();
    state = DetailState.create;
    update();
  }

  void pressedSave() {
    String title = titleController.text.trim().toString();
    String content = bodyController.text.trim().toString();
    if(title.isNotEmpty && content.isNotEmpty) {
      if(state == DetailState.create) {
        _createPost(title, content);
      } else {
        _updatePost(title, content);
      }
    } else {
      Utils.fireSnackGetX("Fields cannot be empty!");
    }
  }

  void _updatePost(String name, String phoneNumber) {
    contact!.name = name;
    contact!.phoneNumber = phoneNumber;
    NetworkService.PUT(NetworkService.API_POST_UPDATE + contact!.id.toString(), contact!.toJson()).then((response) => _checkResponse(response));
  }

  void _createPost(String name, String phoneNumber) {
    contact = Contact(id: "1", name: name, phoneNumber: phoneNumber);
    NetworkService.POST(NetworkService.API_POST_CREATE, NetworkService.bodyCreate(contact!)).then((response) => _checkResponse(response));
  }

  void _checkResponse(String? response) {
    if(response != null) {
      Get.back();
      Get.find<HomeController>().getDataFromNetwork();
      Utils.fireSnackGetX("Your Contact successfully ${state == DetailState.create ? "saved" : "updated"}!");
    } else {
      Utils.fireSnackGetX("Your Contact not saved! Please try again!");
    }
  }
}
