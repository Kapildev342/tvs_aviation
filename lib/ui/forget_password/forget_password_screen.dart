import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/widgets.dart';
import 'package:tvsaviation/ui/code_verify/code_verification_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String id = "forget_password";

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context);
  }

  Widget bodyWidget() {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(),
      child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (BuildContext context, ForgetPasswordState forget) {
          if (forget is ForgetPasswordSuccess) {
            mainVariables.forgetPasswordVariables.loader = mainVariables.forgetPasswordVariables.loader ? false : true;
            Navigator.of(context).pushNamed(CodeVerificationScreen.id, arguments: {"email": mainVariables.forgetPasswordVariables.emailController.text});
            mainWidgets.flushBarWidget(context: context, message: forget.message);
            mainVariables.forgetPasswordVariables.emailController.clear();
          } else if (forget is ForgetPasswordFailure) {
            mainVariables.forgetPasswordVariables.loader = mainVariables.forgetPasswordVariables.loader ? false : true;
            mainWidgets.flushBarWidget(context: context, message: forget.errorMessage);
          }
        },
        builder: (BuildContext context, ForgetPasswordState forget) {
          if (forget is ForgetPasswordLoaded) {
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
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 40),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 460),
                              width: mainFunctions.getWidgetWidth(width: 586),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: mainFunctions.getWidgetHeight(height: 60),
                                    width: mainFunctions.getWidgetWidth(width: 60),
                                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/forget_password/exclamatory.png"), fit: BoxFit.fill)),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 20),
                                  ),
                                  Text(
                                    "Forgot Password",
                                    style: mainTextStyle.headingBlueTextStyle.copyWith(color: mainColors.headingBlueColor),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 8),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 586),
                                    child: Text(
                                      "Enter your email id below, associated with this account and we will send you a code to reset the password.",
                                      style: mainTextStyle.normalTextStyle.copyWith(color: const Color(0XFF707070), fontSize: mainFunctions.getTextSize(fontSize: 16)),
                                      textAlign: TextAlign.center,
                                    ),
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
                                          controller: mainVariables.forgetPasswordVariables.emailController,
                                          style: mainTextStyle.normalTextStyle,
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
                                        mainVariables.forgetPasswordVariables.emailEmpty
                                            ? Text(
                                                "email field is empty, please enter valid email",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                              )
                                            : mainVariables.forgetPasswordVariables.isEmailValid
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
                                ],
                              ),
                            ),
                            LoadingButton(
                              status: mainVariables.forgetPasswordVariables.loader,
                              onTap: () {
                                context.read<ForgetPasswordBloc>().add(const CodeSendingEvent());
                              },
                              text: 'Send Code',
                              width: mainFunctions.getWidgetWidth(width: 560),
                            ),
                            Container(
                              height: mainFunctions.getWidgetHeight(height: 200),
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
      ),
    );
  }
}
