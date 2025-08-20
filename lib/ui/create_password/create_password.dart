import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/bloc/create_password/create_password_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/widgets.dart';
import 'package:tvsaviation/ui/login/login_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  static const String id = "create_password";
  final Map<String, dynamic> arguments;
  const CreatePasswordScreen({super.key, required this.arguments});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  @override
  void dispose() {
    mainVariables.createPasswordVariables.loader = false;
    mainVariables.createPasswordVariables.isNewVisible = true;
    mainVariables.createPasswordVariables.isNewVisible = true;
    mainVariables.createPasswordVariables.newPassword.clear();
    mainVariables.createPasswordVariables.confirmPassword.clear();
    mainVariables.createPasswordVariables.isPasswordEmpty = false;
    mainVariables.createPasswordVariables.isCorrectPassword = true;
    mainVariables.createPasswordVariables.isMatched = true;
    mainVariables.createPasswordVariables.forMatchedText = false;
    mainVariables.createPasswordVariables.counter = 0;
    mainVariables.createPasswordVariables.passwordStatus = "Very Week";
    mainVariables.createPasswordVariables.passwordStrength = 0.0;
    mainVariables.createPasswordVariables.progressColor = Colors.blue;
    mainVariables.createPasswordVariables.upperCase = false;
    mainVariables.createPasswordVariables.lowerCase = false;
    mainVariables.createPasswordVariables.symbolCase = false;
    mainVariables.createPasswordVariables.numberCase = false;
    mainVariables.createPasswordVariables.lengthCase = false;
    super.dispose();
  }

  @override
  void initState() {
    mainVariables.createPasswordVariables.loader = false;
    mainVariables.createPasswordVariables.isNewVisible = true;
    mainVariables.createPasswordVariables.isConfirmVisible = true;
    mainVariables.createPasswordVariables.isPasswordEmpty = false;
    mainVariables.createPasswordVariables.isMatched = true;
    mainVariables.createPasswordVariables.forMatchedText = false;
    mainVariables.createPasswordVariables.isCorrectPassword = true;
    mainVariables.createPasswordVariables.passwordStatus = "Very Weak";
    mainVariables.createPasswordVariables.passwordStrength = 0.0;
    mainVariables.createPasswordVariables.counter = 0;
    mainVariables.createPasswordVariables.progressColor = Colors.blue;
    mainVariables.createPasswordVariables.newPassword.clear();
    mainVariables.createPasswordVariables.confirmPassword.clear();
    mainVariables.createPasswordVariables.lowerCase = false;
    mainVariables.createPasswordVariables.upperCase = false;
    mainVariables.createPasswordVariables.lengthCase = false;
    mainVariables.createPasswordVariables.symbolCase = false;
    mainVariables.createPasswordVariables.numberCase = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false, onPopInvoked: (value) {}, child: mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context));
  }

  Widget bodyWidget() {
    return BlocProvider(
      create: (context) => CreatePasswordBloc(),
      child: BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
        listener: (BuildContext context, CreatePasswordState create) {
          if (create is CreatePasswordSuccess) {
            Navigator.of(context, rootNavigator: true).pushNamed(LoginScreen.id);
            mainWidgets.flushBarWidget(context: context, message: create.message);
          } else if (create is CreatePasswordFailure) {
            mainWidgets.flushBarWidget(context: context, message: create.errorMessage);
          }
        },
        builder: (BuildContext context, CreatePasswordState create) {
          if (create is CreatePasswordLoaded) {
            return ListView(
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
                  width: mainFunctions.getWidgetWidth(width: 586),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "Create New Password",
                          style: mainTextStyle.headingBlueTextStyle.copyWith(color: mainColors.headingBlueColor),
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 8),
                      ),
                      Text(
                        "The password should be different from the previous one.",
                        style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0XFF707070)),
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
                              "New password",
                              style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.normalLabelColor),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 10),
                            ),
                            TextFormField(
                              controller: mainVariables.createPasswordVariables.newPassword,
                              style: mainTextStyle.normalTextStyle,
                              obscureText: mainVariables.createPasswordVariables.isNewVisible,
                              onTap: () {
                                if (mainVariables.createPasswordVariables.newPassword.text != "") {
                                  context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                                }
                              },
                              onTapOutside: (value) {
                                context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                              },
                              onFieldSubmitted: (value) {
                                context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onEditingComplete: () {
                                context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onChanged: (value) {
                                context.read<CreatePasswordBloc>().add(ProgressBarEvent(value: value));
                              },
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
                                    context.read<CreatePasswordBloc>().add(const CreateNewPasswordVisibleEvent());
                                  },
                                  child: mainVariables.createPasswordVariables.isNewVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                ),
                                hintText: "Enter your Password",
                                hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 17), fontWeight: FontWeight.w400),
                              ),
                            ),
                            mainVariables.createPasswordVariables.isPasswordEmpty
                                ? Text(
                                    "Password field is empty, Please enter strong password",
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                  )
                                : const SizedBox(),
                            mainVariables.createPasswordVariables.isCorrectPassword
                                ? const SizedBox()
                                : Text(
                                    "Entered password is ${mainVariables.createPasswordVariables.passwordStatus}, Please follow the below instructions",
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 15),
                      ),
                      mainVariables.createPasswordVariables.newPassword.text.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: mainFunctions.getWidgetWidth(width: 586),
                              padding: EdgeInsets.symmetric(
                                horizontal: mainFunctions.getWidgetWidth(width: 25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Strength : ${mainVariables.createPasswordVariables.passwordStatus}"),
                                  LinearProgressIndicator(
                                    value: mainVariables.createPasswordVariables.passwordStrength,
                                    borderRadius: BorderRadius.circular(15),
                                    color: mainVariables.createPasswordVariables.progressColor,
                                  ),
                                ],
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
                              "Confirm password",
                              style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.normalLabelColor),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 10),
                            ),
                            TextFormField(
                              controller: mainVariables.createPasswordVariables.confirmPassword,
                              style: mainTextStyle.normalTextStyle,
                              obscureText: mainVariables.createPasswordVariables.isConfirmVisible,
                              onTap: () {
                                if (mainVariables.createPasswordVariables.confirmPassword.text != "") {
                                  context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                                }
                              },
                              onTapOutside: (value) {
                                context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                              },
                              onFieldSubmitted: (value) {
                                context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onEditingComplete: () {
                                context.read<CreatePasswordBloc>().add(const PasswordValidatingEvent());
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onChanged: (value) {
                                context.read<CreatePasswordBloc>().add(const RefreshEvent());
                              },
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
                                    context.read<CreatePasswordBloc>().add(const CreateConfirmPasswordVisibleEvent());
                                  },
                                  child: mainVariables.createPasswordVariables.isConfirmVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                                ),
                                hintText: "Re-type your password",
                                hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 17), fontWeight: FontWeight.w400),
                              ),
                            ),
                            mainVariables.createPasswordVariables.forMatchedText
                                ? Text(
                                    "passwords are perfectly matched",
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.green),
                                  )
                                : const SizedBox(),
                            mainVariables.createPasswordVariables.isMatched
                                ? const SizedBox()
                                : Text(
                                    "passwords are not matched",
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 40),
                      ),
                      LoadingButton(
                        status: mainVariables.createPasswordVariables.loader,
                        onTap: () {
                          if (mainVariables.createPasswordVariables.forMatchedText) {
                            context.read<CreatePasswordBloc>().add(CreatePasswordButtonEvent(email: widget.arguments["email"]));
                          }
                        },
                        text: 'Confirm',
                        width: mainFunctions.getWidgetWidth(width: 560),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 40),
                      ),
                      Container(
                        width: mainFunctions.getWidgetWidth(width: 586),
                        padding: EdgeInsets.symmetric(
                          horizontal: mainFunctions.getWidgetWidth(width: 13),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your password must contain",
                                  style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0XFF707070)),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: mainVariables.createPasswordVariables.lengthCase ? Colors.green : Colors.grey,
                                      size: 20,
                                    ),
                                    Text(
                                      "  Should contain 8 to 40 characters.",
                                      style: mainTextStyle.smallTextStyle.copyWith(
                                        color: const Color(0XFF707070),
                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: mainVariables.createPasswordVariables.upperCase ? Colors.green : Colors.grey,
                                      size: 20,
                                    ),
                                    Text(
                                      "  At least use one upper case.",
                                      style: mainTextStyle.smallTextStyle.copyWith(
                                        color: const Color(0XFF707070),
                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: mainVariables.createPasswordVariables.lowerCase ? Colors.green : Colors.grey,
                                      size: 20,
                                    ),
                                    Text(
                                      "  At least use  one lower case.",
                                      style: mainTextStyle.smallTextStyle.copyWith(
                                        color: const Color(0XFF707070),
                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: mainVariables.createPasswordVariables.symbolCase ? Colors.green : Colors.grey,
                                      size: 20,
                                    ),
                                    Text(
                                      "  At least one special character.",
                                      style: mainTextStyle.smallTextStyle.copyWith(
                                        color: const Color(0XFF707070),
                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: mainVariables.createPasswordVariables.numberCase ? Colors.green : Colors.grey,
                                      size: 20,
                                    ),
                                    Text(
                                      "  At least one number.",
                                      style: mainTextStyle.smallTextStyle.copyWith(
                                        color: const Color(0XFF707070),
                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
