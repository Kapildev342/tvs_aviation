import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tvsaviation/data/hive/user/user_data.dart';
import 'package:tvsaviation/data/model/api_model/login_api_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginLoaded()) {
    on<LoginInitialEvent>(loginInitFunction);
    on<LoginButtonEvent>(loginFunction);
    on<PasswordVisibleEvent>(visibleFunction);
  }

  FutureOr<void> loginInitFunction(LoginInitialEvent event, Emitter<LoginState> emit) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    if(Platform.isIOS){
      await firebaseMessaging.getAPNSToken().then((token){
        mainVariables.loginVariables.fcmtoken = token ?? "";
      });
    }else{
      firebaseMessaging.getToken().then((token) {
        mainVariables.loginVariables.fcmtoken = token ?? "";
      });
    }

    emit(LoginDummy());
    emit(const LoginLoaded());
  }

  FutureOr<void> loginFunction(LoginButtonEvent event, Emitter<LoginState> emit) async {
    mainVariables.loginVariables.loader = mainVariables.loginVariables.loader ? false : true;
    emit(LoginDummy());
    emit(const LoginLoaded());
    if (mainVariables.loginVariables.emailController.text == "" || mainVariables.loginVariables.passwordController.text == "") {
      if (mainVariables.loginVariables.emailController.text == "" && mainVariables.loginVariables.passwordController.text == "") {
        mainVariables.loginVariables.emailEmpty = true;
        mainVariables.loginVariables.passwordEmpty = true;
        mainVariables.loginVariables.isEmailValid = false;
      } else if (mainVariables.loginVariables.emailController.text == "" && mainVariables.loginVariables.passwordController.text != "") {
        mainVariables.loginVariables.emailEmpty = true;
        mainVariables.loginVariables.passwordEmpty = false;
        mainVariables.loginVariables.isEmailValid = false;
      } else if (mainVariables.loginVariables.emailController.text != "" && mainVariables.loginVariables.passwordController.text == "") {
        mainVariables.loginVariables.emailEmpty = false;
        mainVariables.loginVariables.passwordEmpty = true;
        mainVariables.loginVariables.isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mainVariables.loginVariables.emailController.text);
      } else {
        mainVariables.loginVariables.emailEmpty = false;
        mainVariables.loginVariables.passwordEmpty = false;
        mainVariables.loginVariables.isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mainVariables.loginVariables.emailController.text);
      }
      mainVariables.loginVariables.loader = mainVariables.loginVariables.loader ? false : true;
      emit(LoginDummy());
      emit(const LoginLoaded());
    } else {
      mainVariables.loginVariables.emailEmpty = false;
      mainVariables.loginVariables.passwordEmpty = false;
      mainVariables.loginVariables.isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mainVariables.loginVariables.emailController.text);
      if (mainVariables.loginVariables.isEmailValid) {
        await mainVariables.repoImpl
            .getLogin(userName: mainVariables.loginVariables.emailController.text.trim(), password: mainVariables.loginVariables.passwordController.text, fcmToken: mainVariables.loginVariables.fcmtoken)
            .onError((error, stackTrace) {
          mainVariables.loginVariables.loader = mainVariables.loginVariables.loader ? false : true;
          emit(LoginFailure(errorMessage: error.toString()));
          emit(const LoginLoaded());
        }).then((value) async {
          if (value != null) {
            LoginApiModel loginResponse = LoginApiModel.fromJson(value);
            if (loginResponse.status) {
              mainVariables.generalVariables.userToken = loginResponse.token;
              UserResponse userResponse = UserResponse(
                token: loginResponse.token,
                user: User(
                  id: loginResponse.user.id,
                  firstName: loginResponse.user.firstName,
                  lastName: loginResponse.user.lastName,
                  email: loginResponse.user.email,
                  role: loginResponse.user.role,
                  createdAt: DateTime.parse(loginResponse.user.createdAt),
                  updatedAt: DateTime.parse(loginResponse.user.updatedAt),
                  activeStatus: loginResponse.user.activeStatus,
                  verificationCode: loginResponse.user.verificationCode,
                  verificationCodeExpiry: loginResponse.user.verificationCodeExpiry == "" ? DateTime.now() : DateTime.parse(loginResponse.user.verificationCodeExpiry),
                  profilePhoto: loginResponse.user.profilePhoto,
                ),
                status: loginResponse.status,
              );
              var box = Hive.box('boxData');
              await box.put('user_response', userResponse);
              mainVariables.loginVariables.loader = mainVariables.loginVariables.loader ? false : true;
              emit(const LoginSuccess());
              emit(const LoginLoaded());
              mainVariables.loginVariables.emailController.clear();
              mainVariables.loginVariables.passwordController.clear();
            } else {
              mainVariables.loginVariables.loader = mainVariables.loginVariables.loader ? false : true;
              emit(LoginFailure(errorMessage: loginResponse.message));
              emit(const LoginLoaded());
            }
          }
        });
      } else {
        mainVariables.loginVariables.loader = mainVariables.loginVariables.loader ? false : true;
        emit(LoginDummy());
        emit(const LoginLoaded());
      }
    }
  }

  FutureOr<void> visibleFunction(PasswordVisibleEvent event, Emitter<LoginState> emit) async {
    mainVariables.loginVariables.isVisible = mainVariables.loginVariables.isVisible ? false : true;
    emit(LoginDummy());
    emit(const LoginLoaded());
  }
}
