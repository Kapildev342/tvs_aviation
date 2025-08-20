import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/bloc/login/login_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/main.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/widgets.dart';
import 'package:tvsaviation/ui/forget_password/forget_password_screen.dart';
import 'package:tvsaviation/ui/rail_navigation/rail_navigation.dart';
import 'package:upgrader/upgrader.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    context.read<LoginBloc>().add(const LoginInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
        child: UpgradeAlert(
            dialogStyle: Platform.isAndroid ? UpgradeDialogStyle.material : UpgradeDialogStyle.cupertino,
            showReleaseNotes: false,
            showIgnore: false,
            shouldPopScope: () => true,
            upgrader: Upgrader(
              messages: MyUpGraderMessages(),
            ),
            child: mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context)));
  }

  Widget bodyWidget() {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, LoginState login) {
        if (login is LoginSuccess) {
          mainVariables.loginVariables.isVisible = true;
          mainVariables.generalVariables.railNavigateIndex = 0;
          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          Navigator.of(context).pushNamed(RailNavigationScreen.id);
        } else if (login is LoginError) {
          mainWidgets.flushBarWidget(context: context, message: "Invalid Credentials");
        } else if (login is LoginFailure) {
          mainWidgets.flushBarWidget(context: context, message: login.errorMessage);
        }
      },
      builder: (BuildContext context, LoginState builderLogin) {
        if (builderLogin is LoginLoaded) {
          return ListView(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Column(
                    children: [
                      Container(
                        height: mainFunctions.getWidgetHeight(height: 350),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/login/login_dash.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 15),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 412),
                        width: mainFunctions.getWidgetWidth(width: 586),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                "Welcome",
                                style: mainTextStyle.headingBlueTextStyle.copyWith(color: mainColors.headingBlueColor),
                              ),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 8),
                            ),
                            Text(
                              "Your wings already exist, all you have to do is FLY.",
                              style: mainTextStyle.normalTextStyle.copyWith(color: const Color(0XFF707070)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 15),
                            ),
                            Container(
                              width: mainFunctions.getWidgetWidth(width: 586),
                              padding: EdgeInsets.symmetric(
                                horizontal: mainFunctions.getWidgetWidth(width: 13),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "E mail",
                                    style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.normalLabelColor),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 10),
                                  ),
                                  TextFormField(
                                    controller: mainVariables.loginVariables.emailController,
                                    style: mainTextStyle.normalTextStyle,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      fillColor: const Color(0xFFEDEDED),
                                      filled: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      hintText: "Enter your E-mail",
                                      hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 17), fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  mainVariables.loginVariables.emailEmpty
                                      ? Text(
                                          "email field is empty, please enter valid email",
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                        )
                                      : mainVariables.loginVariables.isEmailValid
                                          ? const SizedBox()
                                          : Text(
                                              "entered email id is not valid, please enter valid email",
                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                            ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 30),
                            ),
                            Container(
                              width: mainFunctions.getWidgetWidth(width: 586),
                              padding: EdgeInsets.symmetric(
                                horizontal: mainFunctions.getWidgetWidth(width: 13),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password",
                                    style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.normalLabelColor),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 10),
                                  ),
                                  TextFormField(
                                    controller: mainVariables.loginVariables.passwordController,
                                    style: mainTextStyle.normalTextStyle,
                                    obscureText: mainVariables.loginVariables.isVisible,
                                    decoration: InputDecoration(
                                      fillColor: const Color(0xFFEDEDED),
                                      filled: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          context.read<LoginBloc>().add(const PasswordVisibleEvent());
                                        },
                                        child: mainVariables.loginVariables.isVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                      ),
                                      hintText: "Enter your password",
                                      hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 17), fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  mainVariables.loginVariables.passwordEmpty
                                      ? Text(
                                          "password field is empty, please enter your password",
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                        )
                                      : const SizedBox(),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context, rootNavigator: true).pushNamed(ForgetPasswordScreen.id);
                                        },
                                        child: Text(
                                          "forgot password?",
                                          style: mainTextStyle.smallTextStyle.copyWith(color: mainColors.smallTextColor),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 60),
                      ),
                      LoadingButton(
                        status: mainVariables.loginVariables.loader,
                        onTap: () {
                          mainVariables.generalVariables.railNavigateIndex = 0;
                          context.read<LoginBloc>().add(const LoginButtonEvent());
                        },
                        text: 'Login',
                        width: mainFunctions.getWidgetWidth(width: 560),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 190),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(340 / 360),
                        child: Container(
                          height: mainFunctions.getWidgetHeight(height: 200),
                          width: mainFunctions.getWidgetWidth(width: 600),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/login/airplane.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          transform: Matrix4.translationValues(-180, -30.0, 0.0),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ],
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
