import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/send_otp_model.dart';
import 'package:tvsaviation/data/model/api_model/verify_otp_model.dart';
import 'package:tvsaviation/resources/constants.dart';
part 'code_verify_event.dart';
part 'code_verify_state.dart';

class CodeVerifyBloc extends Bloc<CodeVerifyEvent, CodeVerifyState> {
  CodeVerifyBloc() : super(const CodeVerifyLoaded()) {
    on<CodeVerifyTimerEvent>(timerFunction);
    on<OtpValidatingEvent>(otpValidatingFunction);
    on<ResendCodeEvent>(resendCodeFunction);
  }

  Future<void> timerFunction(CodeVerifyTimerEvent event, Emitter<CodeVerifyState> emit) async {
    if (event.response) {
      emit(CodeVerifyDummy());
      emit(const CodeVerifyLoaded());
    } else {
      emit(CodeVerifyDummy());
      emit(const CodeVerifyLoaded());
    }
  }

  Future<void> otpValidatingFunction(OtpValidatingEvent event, Emitter<CodeVerifyState> emit) async {
    mainVariables.codeVerifyVariables.loader = true;
    if (mainVariables.codeVerifyVariables.otpController.text == "") {
      mainVariables.codeVerifyVariables.otpEmpty = true;
      mainVariables.codeVerifyVariables.otpNotFilled = false;
      mainVariables.codeVerifyVariables.loader = mainVariables.codeVerifyVariables.loader ? false : true;
      emit(CodeVerifyDummy());
      emit(const CodeVerifyLoaded());
    } else if (mainVariables.codeVerifyVariables.otpController.text.length != 6) {
      mainVariables.codeVerifyVariables.otpEmpty = false;
      mainVariables.codeVerifyVariables.otpNotFilled = true;
      mainVariables.codeVerifyVariables.loader = mainVariables.codeVerifyVariables.loader ? false : true;
      emit(CodeVerifyDummy());
      emit(const CodeVerifyLoaded());
    } else {
      mainVariables.codeVerifyVariables.otpEmpty = false;
      mainVariables.codeVerifyVariables.otpNotFilled = false;
      await mainVariables.repoImpl
          .otpValidation(
        email: event.email,
        otp: mainVariables.codeVerifyVariables.otpController.text,
      )
          .onError((error, stackTrace) {
        emit(CodeVerifyFailure(errorMessage: error.toString()));
        emit(const CodeVerifyLoaded());
      }).then((value) async {
        if (value != null) {
          VerifyOtpModel verifyOtpResponse = VerifyOtpModel.fromJson(value);
          if (verifyOtpResponse.status) {
            emit(CodeVerifySuccess(message: verifyOtpResponse.message));
            emit(const CodeVerifyLoaded());
          } else {
            emit(CodeVerifyFailure(errorMessage: verifyOtpResponse.message));
            emit(const CodeVerifyLoaded());
          }
        }
      });
    }
  }

  Future<void> resendCodeFunction(ResendCodeEvent event, Emitter<CodeVerifyState> emit) async {
    await mainVariables.repoImpl.sendOtpResend(email: event.email).onError((error, stackTrace) {
      mainVariables.codeVerifyVariables.loader = false;
      emit(CodeVerifyFailure(errorMessage: error.toString()));
      emit(const CodeVerifyLoaded());
    }).then((value) async {
      if (value != null) {
        SendOtpModel sendOtpResponse = SendOtpModel.fromJson(value);
        if (sendOtpResponse.status) {
          emit(CodeVerifyResendSuccess(message: sendOtpResponse.message));
          emit(const CodeVerifyLoaded());
        } else {
          mainVariables.codeVerifyVariables.loader = false;
          emit(CodeVerifyFailure(errorMessage: sendOtpResponse.message));
          emit(const CodeVerifyLoaded());
        }
      }
    });
  }
}
