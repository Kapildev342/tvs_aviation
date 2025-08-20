import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tvsaviation/bloc/code_verify/code_verify_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/widgets.dart';
import 'package:tvsaviation/ui/create_password/create_password.dart';

class CodeVerificationScreen extends StatefulWidget {
  static const String id = "code_verify";
  final Map<String, dynamic> arguments;
  const CodeVerificationScreen({super.key, required this.arguments});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  @override
  void initState() {
    mainVariables.codeVerifyVariables.loader = false;
    timerFunction();
    super.initState();
  }

  timerFunction() async {
    mainVariables.codeVerifyVariables.timerCount = 30;
    mainVariables.codeVerifyVariables.enableResend = false;
    mainVariables.codeVerifyVariables.timer = Timer.periodic(const Duration(seconds: 1), (val) {
      if (mainVariables.codeVerifyVariables.timerCount == 0) {
        mainVariables.codeVerifyVariables.enableResend = true;
        mainVariables.codeVerifyVariables.timer!.cancel();
        context.read<CodeVerifyBloc>().add(const CodeVerifyTimerEvent(response: true));
      } else {
        mainVariables.codeVerifyVariables.enableResend = false;
        mainVariables.codeVerifyVariables.timerCount--;
        context.read<CodeVerifyBloc>().add(const CodeVerifyTimerEvent(response: false));
      }
    });
  }

  @override
  void dispose() {
    mainVariables.codeVerifyVariables.otpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context);
  }

  Widget bodyWidget() {
    return BlocConsumer<CodeVerifyBloc, CodeVerifyState>(
      listener: (BuildContext context, CodeVerifyState codeVerify) {
        if (codeVerify is CodeVerifySuccess) {
          Navigator.of(context).pushNamed(CreatePasswordScreen.id, arguments: {"email": widget.arguments["email"]});
          mainWidgets.flushBarWidget(context: context, message: codeVerify.message);
          mainVariables.codeVerifyVariables.loader = false;
          mainVariables.codeVerifyVariables.otpController.clear();
        } else if (codeVerify is CodeVerifyFailure) {
          mainWidgets.flushBarWidget(context: context, message: codeVerify.errorMessage);
          mainVariables.codeVerifyVariables.loader = false;
        } else if (codeVerify is CodeVerifyResendSuccess) {
          mainWidgets.flushBarWidget(context: context, message: codeVerify.message);
        }
      },
      builder: (BuildContext context, CodeVerifyState codeVerify) {
        if (codeVerify is CodeVerifyLoaded) {
          return Stack(
            children: [
              ListView(
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
                          SizedBox(height: mainFunctions.getWidgetHeight(height: 40)),
                          SizedBox(
                            width: mainFunctions.getWidgetWidth(width: 586),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Enter Verification Code", style: mainTextStyle.headingBlueTextStyle.copyWith(color: mainColors.headingBlueColor)),
                                SizedBox(height: mainFunctions.getWidgetHeight(height: 8)),
                                SizedBox(
                                  width: mainFunctions.getWidgetWidth(width: 586),
                                  child: Text(
                                    "We have sent the code to ${widget.arguments["email"]}",
                                    style: mainTextStyle.normalTextStyle.copyWith(color: const Color(0XFF707070), fontSize: mainFunctions.getTextSize(fontSize: 16)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: mainFunctions.getWidgetHeight(height: 15)),
                                Container(
                                  width: mainFunctions.getWidgetWidth(width: 586),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: mainFunctions.getWidgetWidth(width: 13),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 40),
                                      ),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 66),
                                        width: mainFunctions.getWidgetWidth(width: 586),
                                        child: PinCodeTextField(
                                          length: 6,
                                          appContext: context,
                                          controller: mainVariables.codeVerifyVariables.otpController,
                                          keyboardType: TextInputType.number,
                                          enableActiveFill: true,
                                          cursorColor: Colors.black,
                                          autoDisposeControllers: false,
                                          onChanged: (code) {},
                                          pinTheme: PinTheme(
                                              inactiveColor: Colors.transparent,
                                              activeColor: Colors.transparent,
                                              selectedColor: Colors.transparent,
                                              inactiveFillColor: const Color(0xFFEDEDED),
                                              activeFillColor: const Color(0xFFEDEDED),
                                              selectedFillColor: const Color(0xFFEDEDED),
                                              inactiveBorderWidth: 1.5,
                                              selectedBorderWidth: 1.5,
                                              shape: PinCodeFieldShape.box,
                                              borderRadius: BorderRadius.circular(10.0),
                                              fieldHeight: mainFunctions.getWidgetHeight(height: 66),
                                              fieldWidth: mainFunctions.getWidgetWidth(width: 66),
                                              borderWidth: 1.5),
                                        ),
                                      ),
                                      mainVariables.codeVerifyVariables.otpEmpty
                                          ? Text(
                                              "otp field is empty, please enter valid received otp",
                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                            )
                                          : mainVariables.codeVerifyVariables.otpNotFilled
                                              ? Text(
                                                  "Please ensure that you have filled all the fields",
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                                )
                                              : const SizedBox(),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 5),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Resend code in ${mainVariables.codeVerifyVariables.timerCount}s",
                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: mainFunctions.getWidgetHeight(height: 35)),
                              ],
                            ),
                          ),
                          LoadingButton(
                            status: mainVariables.codeVerifyVariables.loader,
                            onTap: () {
                              context.read<CodeVerifyBloc>().add(OtpValidatingEvent(email: widget.arguments["email"]));
                            },
                            text: 'Continue',
                            width: mainFunctions.getWidgetWidth(width: 560),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 22),
                          ),
                          SizedBox(
                            width: mainFunctions.getWidgetWidth(width: 586),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "if you didn’t receive a code.",
                                  style: mainTextStyle.normalTextStyle.copyWith(color: const Color(0XFF707070), fontSize: mainFunctions.getTextSize(fontSize: 16)),
                                  textAlign: TextAlign.center,
                                ),
                                TextButton(
                                    onPressed: mainVariables.codeVerifyVariables.enableResend
                                        ? () {
                                            timerFunction();
                                            context.read<CodeVerifyBloc>().add(ResendCodeEvent(email: widget.arguments["email"]));
                                          }
                                        : () {},
                                    child: Text(
                                      "Resend code",
                                      style: mainTextStyle.smallTextStyle.copyWith(color: mainVariables.codeVerifyVariables.enableResend ? mainColors.smallTextColor : Colors.grey.shade200),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 305),
                          ),
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
              ),
              Positioned(
                top: mainFunctions.getWidgetHeight(height: 15),
                left: mainFunctions.getWidgetWidth(width: 15),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
