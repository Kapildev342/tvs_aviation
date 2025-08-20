import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tvsaviation/bloc/check_list/check_list_bloc.dart';
import 'package:tvsaviation/bloc/home/home_bloc.dart';
import 'package:tvsaviation/bloc/inventory/inventory_bloc.dart';
import 'package:tvsaviation/bloc/manage/manage_bloc.dart';
import 'package:tvsaviation/bloc/manual/manual_bloc.dart';
import 'package:tvsaviation/bloc/notification/notification_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/bloc/stock_movement/stock_movement_bloc.dart';
import 'package:tvsaviation/data/hive/crew/crew_data.dart';
import 'package:tvsaviation/data/hive/handler/handler_data.dart';
import 'package:tvsaviation/data/hive/sector/sector_data.dart';
import 'package:tvsaviation/data/hive/stock_type/stock_type_data.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/routes/route_generator.dart';
import 'package:tvsaviation/ui/splash/splash_screen.dart';
import 'package:upgrader/upgrader.dart';
import 'bloc/code_verify/code_verify_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/rail_navigation/rail_navigation_bloc.dart';
import 'bloc/splash/splash_bloc.dart';
import 'bloc/transit/transit_bloc.dart';
import 'data/hive/category/category_data.dart';
import 'data/hive/location/location_data.dart';
import 'data/hive/user/user_data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFlutterNotifications();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
  Hive.registerAdapter(UserResponseAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LocationResponseAdapter());
  Hive.registerAdapter(StockTypeResponseAdapter());
  Hive.registerAdapter(CrewResponseAdapter());
  Hive.registerAdapter(SectorResponseAdapter());
  Hive.registerAdapter(HandlerResponseAdapter());
  Hive.registerAdapter(CategoryResponseAdapter());
  await Hive.openBox('boxData');
  await Hive.openBox<LocationResponse>('locations');
  await Hive.openBox<StockTypeResponse>('stockType');
  await Hive.openBox<CrewResponse>('crew');
  await Hive.openBox<SectorResponse>('sector');
  await Hive.openBox<HandlerResponse>('handler');
  await Hive.openBox<CategoryResponse>('category');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      mainVariables.generalVariables.height = MediaQuery.of(context).size.height;
      mainVariables.generalVariables.width = MediaQuery.of(context).size.width;
      mainVariables.generalVariables.text = MediaQuery.of(context).textScaler;
    } else {
      mainVariables.generalVariables.height = MediaQuery.of(context).size.width;
      mainVariables.generalVariables.width = MediaQuery.of(context).size.height;
      mainVariables.generalVariables.text = MediaQuery.of(context).textScaler;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => CodeVerifyBloc()),
        BlocProvider(create: (context) => RailNavigationBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => InventoryBloc()),
        BlocProvider(create: (context) => ReportsBloc()),
        BlocProvider(create: (context) => CheckListBloc()),
        BlocProvider(create: (context) => ManageBloc()),
        BlocProvider(create: (context) => ManualBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => StockMovementBloc()),
        BlocProvider(create: (context) => TransitBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TVS Aviation',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          fontFamily: "Figtree",
        ),
        initialRoute: SplashScreen.id,
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setupFlutterNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  DarwinInitializationSettings initializationSettingsDarwin = const DarwinInitializationSettings(
    requestAlertPermission: false,
    requestSoundPermission: false,
    requestBadgePermission: true,
  );
  InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "TVS_1234",
    'TVS_AVIATION',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails("TVS_1234", 'TVS_AVIATION', importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    NotificationDetails platformChannelSpecifics = const NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, platformChannelSpecifics);
  } else {
    DarwinNotificationDetails iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(notification.hashCode, notification!.title, notification.body, platformChannelSpecifics);
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  showFlutterNotification(message);
}

class MyUpGraderMessages extends UpgraderMessages {
  @override
  String get body => 'A new version of {{appName}} is available';
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
