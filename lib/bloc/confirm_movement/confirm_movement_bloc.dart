import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'confirm_movement_event.dart';
part 'confirm_movement_state.dart';

class ConfirmMovementBloc extends Bloc<ConfirmMovementEvent, ConfirmMovementState> {
  ConfirmMovementBloc() : super(const ConfirmMovementLoaded()) {
    on<ConfirmMovementCreateEvent>(confirmMovementCreateFunction);
  }

  FutureOr<void> confirmMovementCreateFunction(ConfirmMovementCreateEvent event, Emitter<ConfirmMovementState> emit) async {
    await mainVariables.repoImpl.createStockMovement(query: mainVariables.stockMovementVariables.sendData.toJson()).onError((error, stackTrace) {
      emit(ConfirmMovementFailure(errorMessage: error.toString()));
      emit(const ConfirmMovementLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          emit(ConfirmMovementSuccess(message: value["message"]));
          emit(const ConfirmMovementLoaded());
        } else {
          emit(ConfirmMovementFailure(errorMessage: value["message"]));
          emit(const ConfirmMovementLoaded());
        }
        event.modelSetState(() {
          mainVariables.confirmMovementVariables.loader = false;
        });
      }
    });
  }
}
