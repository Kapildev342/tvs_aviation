import 'package:flutter/material.dart';
import 'package:tvsaviation/ui/code_verify/code_verification_screen.dart';
import 'package:tvsaviation/ui/create_password/create_password.dart';
import 'package:tvsaviation/ui/forget_password/forget_password_screen.dart';
import 'package:tvsaviation/ui/home/home_screen.dart';
import 'package:tvsaviation/ui/inventory/inventory_screen.dart';
import 'package:tvsaviation/ui/login/login_screen.dart';
import 'package:tvsaviation/ui/manage/manage_screen.dart';
import 'package:tvsaviation/ui/manual/manual_screen.dart';
import 'package:tvsaviation/ui/notification/notification_screen.dart';
import 'package:tvsaviation/ui/rail_navigation/rail_navigation.dart';
import 'package:tvsaviation/ui/received_stocks/received_stocks_screen.dart';
import 'package:tvsaviation/ui/reports/reports.dart';
import 'package:tvsaviation/ui/splash/splash_screen.dart';
import 'package:tvsaviation/ui/stock_dispute/add_dispute_screen.dart';
import 'package:tvsaviation/ui/stock_movement/confirm_movement.dart';
import 'package:tvsaviation/ui/transit/transit.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case ForgetPasswordScreen.id:
        return MaterialPageRoute(builder: (context) => const ForgetPasswordScreen());
      case CodeVerificationScreen.id:
        return MaterialPageRoute(builder: (context) => CodeVerificationScreen(arguments: args as Map<String, dynamic>));
      case CreatePasswordScreen.id:
        return MaterialPageRoute(builder: (context) => CreatePasswordScreen(arguments: args as Map<String, dynamic>));
      case RailNavigationScreen.id:
        return MaterialPageRoute(builder: (context) => const RailNavigationScreen());
      case InventoryScreen.id:
        return MaterialPageRoute(builder: (context) => const InventoryScreen());
      /*case StockDisputeScreen.id:
        return MaterialPageRoute(builder: (context) => const StockDisputeScreen());*/
      case ReportsScreen.id:
        return MaterialPageRoute(builder: (context) => const ReportsScreen());
      /*case CheckListScreen.id:
        return MaterialPageRoute(builder: (context) => const CheckListScreen());*/
      case ManageScreen.id:
        return MaterialPageRoute(builder: (context) => const ManageScreen());
      case ManualScreen.id:
        return MaterialPageRoute(builder: (context) => const ManualScreen());
      case NotificationScreen.id:
        return MaterialPageRoute(builder: (context) => const NotificationScreen());
      case ReceivedStocksScreen.id:
        return MaterialPageRoute(builder: (context) => const ReceivedStocksScreen());
      /*case StockMovementScreen.id:
        return MaterialPageRoute(builder: (context) => const StockMovementScreen());*/
      case ConfirmMovementScreen.id:
        return MaterialPageRoute(builder: (context) => const ConfirmMovementScreen());
      case TransitScreen.id:
        return MaterialPageRoute(builder: (context) => const TransitScreen());
      case AddDisputeScreen.id:
        return MaterialPageRoute(builder: (context) => const AddDisputeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}
