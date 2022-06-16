import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:network_contact_app/pages/detail/detail_page.dart';
import 'package:network_contact_app/pages/home/home_page.dart';
import 'package:network_contact_app/services/di_service.dart';

void main() async {
  await DIService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: '/detail',
          page: () => const DetailPage(),
          transition: Transition.leftToRightWithFade,
        ),
      ],
      home: HomePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
