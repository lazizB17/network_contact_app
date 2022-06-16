import 'package:get/get.dart';
import '../../models/contact_model.dart';
import '../../services/network_service.dart';
import '../../services/util_service.dart';
import '../detail/detail_controller.dart';
import '../detail/detail_page.dart';


class HomeController extends GetxController {
  // fields
  List<Contact> items = [];
  bool isLoading = false;

  // #logic method
  @override
  void onInit() {
    super.onInit();
    getDataFromNetwork();
  }

  Future<void> getDataFromNetwork() async {
    isLoading = true;
    update();
    await NetworkService.GET(NetworkService.API_POST, NetworkService.emptyParams()).then((response) => _checkData(response));
  }

  void _checkData(String? response) {
    if(response != null) {
      _showData(response);
    } else {
      Utils.fireSnackGetX("Please try again! Something went error!");
    }
    isLoading = false;
    update();
  }

  void _showData(String response) {
    items = NetworkService.parsePostList(response);
    update();
  }

  void createPost() {
    var detailController = Get.find<DetailController>();
    detailController.clearOldData();
    Get.to(() => const DetailPage());
  }
}