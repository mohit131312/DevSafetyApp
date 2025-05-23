import 'package:flutter/material.dart';
import 'package:flutter_app/features/login/login_controller.dart';
import 'package:flutter_app/features/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'utils/size_config.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();
  final LoginController loginController = Get.put(LoginController());

  runApp(MyApp());
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
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      );
    });
  }
}
