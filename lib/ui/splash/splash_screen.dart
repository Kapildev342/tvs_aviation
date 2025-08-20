import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/bloc/splash/splash_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/ui/login/login_screen.dart';
import 'package:tvsaviation/ui/rail_navigation/rail_navigation.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashBloc>().add(const TimerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (BuildContext context, SplashState splash) {
        if (splash is SplashSuccess) {
          if (mainVariables.generalVariables.isLoggedIn) {
            Navigator.of(context, rootNavigator: true).pushNamed(RailNavigationScreen.id);
          } else {
            Navigator.of(context, rootNavigator: true).pushNamed(LoginScreen.id);
          }
        }
      },
      builder: (BuildContext context, SplashState splash) {
        if (splash is SplashLoaded) {
          return mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context);
        } else if (splash is SplashLoading) {
          return mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context);
        } else {
          return Container();
        }
      },
    );
  }

  Widget bodyWidget() {
    return Center(
        child: Container(
      height: mainFunctions.getWidgetHeight(height: 100),
      width: mainFunctions.getWidgetWidth(width: 345),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/splash/tvs_main_logo.png"))),
    ));
  }
}
