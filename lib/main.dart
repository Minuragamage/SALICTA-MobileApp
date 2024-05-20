import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:salicta_mobile/db/authentication.dart';
import 'package:salicta_mobile/ui/app_view.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAn_27NX29jEZ6izlJHU2pGwfbqi9uGc9M',
      appId: '1:341279407350:android:d3f6bb97538445ffaf00d7',
      messagingSenderId: '341279407350',
      projectId: 'salicta-c56ad',
      storageBucket: "gs://salicta-c56ad.appspot.com",
    ),
  );
  configLoading();
  final user = await Authentication().getLoggedUser();
  print("User >> ${user}");

  runApp( AppView(user?.email));

}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}


