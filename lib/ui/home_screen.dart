import 'package:city_list/home_controller.dart';
import 'package:city_list/ui/button_tile_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  final HomeController controller = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: Text(
              "TYPES OF NATIVE COMMUNICATION METHODS",
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          for (int i = 0; i < 3; i++) ...[
            InkWell(
                onTap: () {
                  controller.onClickDifChannel(i);
                },
                child: ButtonTileWidget(text: controller.nativeMethods[i]))
          ]
        ],
      ),
    );
  }
}
