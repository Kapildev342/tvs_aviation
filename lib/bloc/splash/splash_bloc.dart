import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoaded()) {
    on<TimerEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 3000), () async {
        var box = await Hive.openBox('boxData');
        mainVariables.generalVariables.isLoggedIn = box.containsKey("user_response");
        emit(SplashSuccess());
        emit(SplashLoaded());
      });
    });
  }
}
