//import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:khedma/Pages/Notifications/controller/notofication_controller.dart';
import 'package:khedma/Pages/chat%20page/controller/chat_controller.dart';
import 'package:khedma/Pages/global_controller.dart';
import 'package:khedma/Utils/notification_service.dart';
import 'package:khedma/firebase_api.dart';
import 'package:sizer/sizer.dart';
import 'Locals/langs.dart';
import 'Pages/splash/splash_page.dart';
import 'Themes/themes.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final GlobalController _ = Get.put(GlobalController());

  final NotificationController _notificationController =
      Get.put(NotificationController());

  final ChatController __ = Get.put(ChatController());

  // SystemChrome.restoreSystemUIOverlays();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initializePlatformNotifications();
  await FirebaseApi().initNotifications(_notificationController);
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);

  // await FirebaseApi().handleNotifications();

  // await Utils.initializeNotifications(Utils.flutterLocalNotificationsPlugin);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // ThemesController themesController = Get.put(ThemesController());

  // await themesController.getThemeMode();
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        translations: LocaleString(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        title: 'Khedmah',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashPage(),
        // routes: {
        //   '/notification':
        // },
      );
    });
  }
}
