import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/send_otp_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(const ForgetPasswordLoaded()) {
    on<CodeSendingEvent>(codeSendingFunction);
  }

  FutureOr<void> codeSendingFunction(CodeSendingEvent event, Emitter<ForgetPasswordState> emit) async {
    mainVariables.forgetPasswordVariables.loader = mainVariables.forgetPasswordVariables.loader ? false : true;
    emit(ForgetPasswordDummy());
    emit(const ForgetPasswordLoaded());
    if (mainVariables.forgetPasswordVariables.emailController.text == "") {
      mainVariables.forgetPasswordVariables.emailEmpty = true;
      mainVariables.forgetPasswordVariables.loader = mainVariables.forgetPasswordVariables.loader ? false : true;
      emit(ForgetPasswordDummy());
      emit(const ForgetPasswordLoaded());
    } else {
      mainVariables.forgetPasswordVariables.emailEmpty = false;
      mainVariables.forgetPasswordVariables.isEmailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mainVariables.forgetPasswordVariables.emailController.text);
      if (mainVariables.forgetPasswordVariables.isEmailValid == false) {
        mainVariables.forgetPasswordVariables.loader = mainVariables.forgetPasswordVariables.loader ? false : true;
        emit(ForgetPasswordDummy());
        emit(const ForgetPasswordLoaded());
      } else {
        await mainVariables.repoImpl.sendOtp(email: mainVariables.forgetPasswordVariables.emailController.text.trim()).onError((error, stackTrace) {
          emit(ForgetPasswordFailure(errorMessage: error.toString()));
          emit(const ForgetPasswordLoaded());
        }).then((value) async {
          if (value != null) {
            SendOtpModel sendOtpResponse = SendOtpModel.fromJson(value);
            if (sendOtpResponse.status) {
              emit(ForgetPasswordSuccess(message: sendOtpResponse.message));
              emit(const ForgetPasswordLoaded());
            } else {
              emit(ForgetPasswordFailure(errorMessage: sendOtpResponse.message));
              emit(const ForgetPasswordLoaded());
            }
          }
        });
      }
    }
  }
}
