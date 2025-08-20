import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/send_otp_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'create_password_event.dart';
part 'create_password_state.dart';

class CreatePasswordBloc extends Bloc<CreatePasswordEvent, CreatePasswordState> {
  CreatePasswordBloc() : super(const CreatePasswordLoaded()) {
    on<ProgressBarEvent>(progressBarFunction);
    on<RefreshEvent>(refreshFunction);
    on<CreatePasswordButtonEvent>(createPasswordFunction);
    on<PasswordValidatingEvent>(passwordValidatingFunction);
    on<CreateNewPasswordVisibleEvent>(newPasswordVisibleFunction);
    on<CreateConfirmPasswordVisibleEvent>(confirmPasswordVisibleFunction);
  }

  FutureOr<void> progressBarFunction(ProgressBarEvent event, Emitter<CreatePasswordState> emit) async {
    if (event.value.isNotEmpty) {
      mainVariables.createPasswordVariables.isPasswordEmpty = false;
      mainVariables.createPasswordVariables.isCorrectPassword = true;
      mainVariables.createPasswordVariables.isMatched = true;
      mainVariables.createPasswordVariables.forMatchedText = false;
      mainVariables.createPasswordVariables.counter = 0;
      mainVariables.createPasswordVariables.upperCase = false;
      mainVariables.createPasswordVariables.lowerCase = false;
      mainVariables.createPasswordVariables.symbolCase = false;
      mainVariables.createPasswordVariables.numberCase = false;
      mainVariables.createPasswordVariables.lengthCase = false;
      for (int i = 0; i < event.value.length; i++) {
        if (mainVariables.createPasswordVariables.lowerCase == false && event.value.contains(RegExp(r'[a-z]'))) {
          mainVariables.createPasswordVariables.counter++;
          mainVariables.createPasswordVariables.lowerCase = true;
        }
        if (mainVariables.createPasswordVariables.upperCase == false && event.value.contains(RegExp(r'[A-Z]'))) {
          mainVariables.createPasswordVariables.counter++;
          mainVariables.createPasswordVariables.upperCase = true;
        }
        if (mainVariables.createPasswordVariables.numberCase == false && event.value.contains(RegExp(r'[0-9]'))) {
          mainVariables.createPasswordVariables.counter++;
          mainVariables.createPasswordVariables.numberCase = true;
        }
        if (mainVariables.createPasswordVariables.symbolCase == false && event.value.contains(RegExp(r'[!@#\$%&*()?£\-_=]'))) {
          mainVariables.createPasswordVariables.counter++;
          mainVariables.createPasswordVariables.symbolCase = true;
        }
        if (mainVariables.createPasswordVariables.lengthCase == false && event.value.length > 7 && event.value.length <= 40) {
          mainVariables.createPasswordVariables.counter++;
          mainVariables.createPasswordVariables.lengthCase = true;
        }
      }
      mainVariables.createPasswordVariables.passwordStrength = mainVariables.createPasswordVariables.counter * 0.20;
      mainVariables.createPasswordVariables.passwordStatus = mainVariables.createPasswordVariables.statusList[mainVariables.createPasswordVariables.counter - 1];
      mainVariables.createPasswordVariables.progressColor = mainVariables.createPasswordVariables.colorsList[mainVariables.createPasswordVariables.counter - 1];
    } else {
      mainVariables.createPasswordVariables.isPasswordEmpty = true;
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
    }
    emit(CreatePasswordDummy());
    emit(const CreatePasswordLoaded());
  }

  FutureOr<void> refreshFunction(RefreshEvent event, Emitter<CreatePasswordState> emit) async {
    mainVariables.createPasswordVariables.isMatched = true;
    mainVariables.createPasswordVariables.forMatchedText = false;
    emit(CreatePasswordDummy());
    emit(const CreatePasswordLoaded());
  }

  FutureOr<void> newPasswordVisibleFunction(CreateNewPasswordVisibleEvent event, Emitter<CreatePasswordState> emit) async {
    mainVariables.createPasswordVariables.isNewVisible = mainVariables.createPasswordVariables.isNewVisible ? false : true;
    emit(CreatePasswordDummy());
    emit(const CreatePasswordLoaded());
  }

  FutureOr<void> confirmPasswordVisibleFunction(CreateConfirmPasswordVisibleEvent event, Emitter<CreatePasswordState> emit) async {
    mainVariables.createPasswordVariables.isConfirmVisible = mainVariables.createPasswordVariables.isConfirmVisible ? false : true;
    emit(CreatePasswordDummy());
    emit(const CreatePasswordLoaded());
  }

  FutureOr<void> createPasswordFunction(CreatePasswordButtonEvent event, Emitter<CreatePasswordState> emit) async {
    mainVariables.codeVerifyVariables.loader = mainVariables.codeVerifyVariables.loader ? false : true;
    await mainVariables.repoImpl
        .createPassword(
      email: event.email,
      password: mainVariables.createPasswordVariables.confirmPassword.text,
    )
        .onError((error, stackTrace) {
      mainVariables.codeVerifyVariables.loader = mainVariables.codeVerifyVariables.loader ? false : true;
      emit(CreatePasswordFailure(errorMessage: error.toString()));
      emit(const CreatePasswordLoaded());
    }).then((value) async {
      if (value != null) {
        SendOtpModel createPasswordResponse = SendOtpModel.fromJson(value);
        if (createPasswordResponse.status) {
          mainVariables.codeVerifyVariables.loader = mainVariables.codeVerifyVariables.loader ? false : true;
          emit(CreatePasswordSuccess(message: createPasswordResponse.message));
          emit(const CreatePasswordLoaded());
        } else {
          mainVariables.forgetPasswordVariables.loader = mainVariables.forgetPasswordVariables.loader ? false : true;
          emit(CreatePasswordFailure(errorMessage: createPasswordResponse.message));
          emit(const CreatePasswordLoaded());
        }
      }
    });
  }

  FutureOr<void> passwordValidatingFunction(PasswordValidatingEvent event, Emitter<CreatePasswordState> emit) async {
    if (mainVariables.createPasswordVariables.newPassword.text != "") {
      mainVariables.createPasswordVariables.isPasswordEmpty = false;
      mainVariables.createPasswordVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.createPasswordVariables.newPassword.text);
      if (mainVariables.createPasswordVariables.isCorrectPassword) {
        if (mainVariables.createPasswordVariables.confirmPassword.text != "") {
          if (mainVariables.createPasswordVariables.newPassword.text != mainVariables.createPasswordVariables.confirmPassword.text) {
            mainVariables.createPasswordVariables.isPasswordEmpty = false;
            mainVariables.createPasswordVariables.isCorrectPassword = true;
            mainVariables.createPasswordVariables.isMatched = false;
            mainVariables.createPasswordVariables.forMatchedText = false;
            emit(CreatePasswordDummy());
            emit(const CreatePasswordLoaded());
          } else {
            mainVariables.createPasswordVariables.isPasswordEmpty = false;
            mainVariables.createPasswordVariables.isCorrectPassword = true;
            mainVariables.createPasswordVariables.isMatched = true;
            mainVariables.createPasswordVariables.forMatchedText = true;
            emit(CreatePasswordDummy());
            emit(const CreatePasswordLoaded());
          }
        } else {
          mainVariables.createPasswordVariables.isPasswordEmpty = false;
          mainVariables.createPasswordVariables.isCorrectPassword = true;
          mainVariables.createPasswordVariables.isMatched = true;
          mainVariables.createPasswordVariables.forMatchedText = false;
          emit(CreatePasswordDummy());
          emit(const CreatePasswordLoaded());
        }
      } else {
        mainVariables.createPasswordVariables.isPasswordEmpty = false;
        mainVariables.createPasswordVariables.isCorrectPassword = false;
        mainVariables.createPasswordVariables.isMatched = true;
        mainVariables.createPasswordVariables.forMatchedText = false;
        emit(CreatePasswordDummy());
        emit(const CreatePasswordLoaded());
      }
    } else {
      mainVariables.createPasswordVariables.isPasswordEmpty = true;
      mainVariables.createPasswordVariables.isCorrectPassword = true;
      mainVariables.createPasswordVariables.isMatched = true;
      mainVariables.createPasswordVariables.forMatchedText = false;
      emit(CreatePasswordDummy());
      emit(const CreatePasswordLoaded());
    }
  }
}
