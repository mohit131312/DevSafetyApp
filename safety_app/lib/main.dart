import 'package:flutter/material.dart';
import 'package:flutter_app/features/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'utils/size_config.dart';
import 'package:flutter/services.dart';
// import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await GetStorage.init();

  runApp(MyApp());
  // runApp(
  //   DevicePreview(
  //     // enabled: !kReleaseMode, // Only enable in debug mode
  //     builder: (context) => MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          //SizeConfig().init(constraints, orientation);
          //   SizeConfig().init(context);
          SizeConfig.initWithConstraints(constraints, orientation);

          return GetMaterialApp(
            // locale: DevicePreview.locale(context), //  Add this
            // builder: DevicePreview.appBuilder, //  And this
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      );
    });
  }
}
