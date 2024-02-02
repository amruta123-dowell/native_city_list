import 'package:city_list/ui/ios_channel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class IOSMethodScreen extends GetView<IOSChannelController> {
  IOSChannelController channelController = Get.find<IOSChannelController>();
  IOSMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(controller.selectedButtonIndex == 0
              ? "Method event screen"
              : "Channel event screen"),
          backgroundColor:
              controller.selectedButtonIndex == 0 ? Colors.red : Colors.green),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: controller.cities.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controller
                        .getSelectedCityData(controller.cities[index].name);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: controller.selectedButtonIndex == 0
                            ? Colors.red
                            : Colors.green),
                    child: Text(controller.cities[index].name),
                  ),
                );
              }),
          const SizedBox(
            height: 30,
          ),
          GetBuilder<IOSChannelController>(builder: (controller) {
            return (controller.selectedCityDetails != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Details\n id: ${controller.selectedCityDetails!.id}\n selected city:${controller.selectedCityDetails!.name}\n state:${controller.selectedCityDetails!.state} \n ",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.black, fontSize: 20),
                    ),
                  )
                : const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
