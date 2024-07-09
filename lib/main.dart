import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/prefferences.dart';
import 'package:zoco/background_nt.dart';

import 'app/env.dart';
import 'app/modules/flicks/model/downloads_model.dart';
import 'app/theme/theme.dart';
import 'app/theme/theme_provider.dart';
import 'app/utils/extentions.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await BackgroundNt.init();
  await BackgroundNt.getToken();
  await BackgroundNt.firebaseInIt();
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    FirebaseCrashlytics.instance
        .recordError(exception, stackTrace, fatal: true);
    return true;
  };
  tz.initializeTimeZones();
  await AppPref.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  Stripe.publishableKey = Environments.stripePublishableKey;
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DownloadModelAdapter().typeId)) {
    Hive.registerAdapter(DownloadModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, them, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    Responsive().init(constraints, orientation);
                    return MaterialApp.router(
                      title: 'e-commerce',
                      theme: MyTheme.lightTheme,
                      darkTheme: MyTheme.darkTheme,
                      themeMode: them.themeMode,
                      debugShowCheckedModeBanner: false,
                      routeInformationProvider:
                          AppRouter.router.routeInformationProvider,
                      routeInformationParser:
                          AppRouter.router.routeInformationParser,
                      routerDelegate: AppRouter.router.routerDelegate,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
