import 'package:city_list/ui/ios_channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'button_tile_widget.dart';
import 'ios_channels/ios_method_list_screen.dart';

class IOSChannelScreen extends GetView<IOSChannelController> {
  IOSChannelController controller = Get.put(IOSChannelController());
  IOSChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 56, 197),
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
                  if (i == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IOSMethodScreen()));
                  }
                },
                child: ButtonTileWidget(text: controller.iosChannelTypes[i]))
          ],
        ],
      ),
    );
  }
}
