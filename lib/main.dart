import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_management_app/firebase_options.dart';
import 'package:shop_management_app/services/navigation_services/navigation.dart';
import 'package:shop_management_app/services/navigation_services/route_names.dart';
import 'package:shop_management_app/utils/console_log.dart';
import 'package:shop_management_app/utils/state_change_observer.dart';

String kUserId = '';

void main() {
  runZonedGuarded<void>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      runApp(const ShopApp());

      if (kDebugMode) {
        Bloc.observer = DebuggableBlocObserver(describeStateChanges: false);
      }
    },
    (error, stack) {
      consoleLog("ShopAppError", error: error.toString(), stackTrace: stack);
    },
  );
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0XFF2381AA),
          ),
          useMaterial3: true,
        ),
        initialRoute: RouteNames.splash,
        onGenerateRoute: onGenerateAppRoute(
          AppRoutesFactory(),
        ),
      ),
    );
  }
}
