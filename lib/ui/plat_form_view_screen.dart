// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';

// class PlatformViewScreen extends StatefulWidget {
//   const PlatformViewScreen({super.key});

//   @override
//   State<PlatformViewScreen> createState() => _PlatformViewScreenState();
// }

// class _PlatformViewScreenState extends State<PlatformViewScreen> {
//   // Stream<String> streamCityDetailsFromNative() {
//   //   return getCityDetailsDataEvent
//   //       .receiveBroadcastStream()
//   //       .map((event) => event.toString());
//   // }

//   // final EventChannel getCityDetailsDataEvent =
//   //     const EventChannel("getCityDetailsFromPlatformView");
//   @override
//   Widget build(BuildContext context) {
//     // This is used in the platform side to register the view.
//     const String viewType = '<platform-view-type>';
//     // Pass parameters to the platform side.
//     const Map<String, dynamic> creationParams = <String, dynamic>{};

//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           PlatformViewLink(
//             viewType: viewType,
//             surfaceFactory: (context, controller) {
//               return AndroidViewSurface(
//                 controller: controller as AndroidViewController,
//                 gestureRecognizers: const <Factory<
//                     OneSequenceGestureRecognizer>>{},
//                 hitTestBehavior: PlatformViewHitTestBehavior.opaque,
//               );
//             },
//             onCreatePlatformView: (params) {
//               return PlatformViewsService.initSurfaceAndroidView(
//                 id: params.id,
//                 viewType: viewType,
//                 layoutDirection: TextDirection.ltr,
//                 creationParams: creationParams,
//                 creationParamsCodec: const StandardMessageCodec(),
//                 onFocus: () {
//                   params.onFocusChanged(true);
//                 },
//               )
//                 ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
//                 ..create();
//             },
//           ),
//           // StreamBuilder<String>(
//           //     stream: streamCityDetailsFromNative(),
//           //     builder: (context, snapshot) {
//           //       if (snapshot.hasData) {
//           //         return Text("details ---> ${snapshot.data}");
//           //       }
//           //       return const SizedBox.shrink();
//           //     })
//         ],
//       ),
//     );
//   }
// }

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
  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
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
    );
  }
}
