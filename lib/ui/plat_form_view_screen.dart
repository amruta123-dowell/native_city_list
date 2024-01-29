import 'package:city_list/ui/platform_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class PlatformViewScreen extends StatefulWidget {
  const PlatformViewScreen({super.key});

  @override
  State<PlatformViewScreen> createState() => _PlatformViewScreenState();
}

class _PlatformViewScreenState extends State<PlatformViewScreen> {
  bool shouldNavigate = false;
  Stream<String> streamCityDetailsFromNative() {
    return getCityDetailsDataEvent
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  final EventChannel getCityDetailsDataEvent =
      const EventChannel("getCityDetailsFromPlatformView");
  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: PlatformViewLink(
            viewType: viewType,
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                controller: controller as AndroidViewController,
                gestureRecognizers: const <Factory<
                    OneSequenceGestureRecognizer>>{},
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              );
            },
            onCreatePlatformView: (params) {
              return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: viewType,
                layoutDirection: TextDirection.ltr,
                creationParams: creationParams,
                creationParamsCodec: const StandardMessageCodec(),
                onFocus: () {
                  params.onFocusChanged(true);
                },
              )
                ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                ..create();
            },
          ),
        ),
        StreamBuilder<String>(
            stream: streamCityDetailsFromNative(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                // Extract the selected details
                var selectedDetails = snapShot.data;

                // Set shouldNavigate to true
                shouldNavigate = true;

                // Use addPostFrameCallback to ensure the navigation happens after the frame is built
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Check if shouldNavigate is true before navigating
                  if (shouldNavigate) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PlatformDetailsScreen(
                          details: selectedDetails ?? '',
                        ),
                      ),
                    );

                    // Reset shouldNavigate to false after navigating
                    shouldNavigate = false;
                  }
                });
              } else {}
              return const SizedBox.shrink();
            })
      ],
    );
  }
}
