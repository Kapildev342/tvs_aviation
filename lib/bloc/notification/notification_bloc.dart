import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/notification_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationLoading()) {
    on<NotificationInitialEvent>(initialFunction);
    on<NotificationReadEvent>(readFunction);
  }

  FutureOr<void> initialFunction(NotificationInitialEvent event, Emitter<NotificationState> emit) async {
    emit(const NotificationLoading());
    mainVariables.notificationVariables.tabsEnableList.clear();
    mainVariables.notificationVariables.tabsEnableList = List.generate(6, (index) => false);
    mainVariables.notificationVariables.tabsEnableList[event.index] = true;
    await mainVariables.repoImpl
        .getNotification(
      locationId: event.locationId,
      category: mainVariables.notificationVariables.notificationCategoryList[event.index],
    )
        .onError((error, stackTrace) {
      emit(NotificationFailure(errorMessage: error.toString()));
      emit(const NotificationLoading());
    }).then((value) async {
      if (value != null) {
        NotificationModel notificationResponse = NotificationModel.fromJson(value);
        if (notificationResponse.status) {
          mainVariables.notificationVariables.notifyList = notificationResponse.notifications;
          mainVariables.notificationVariables.unreadCountAll = notificationResponse.unreadCountAll;
          mainVariables.notificationVariables.unreadCountTransit = notificationResponse.unreadCountTransit;
          mainVariables.notificationVariables.unreadCountExpiry = notificationResponse.unreadCountExpiry;
          mainVariables.notificationVariables.unreadCountLowStock = notificationResponse.unreadCountLowStock;
          mainVariables.notificationVariables.unreadCountDispute = notificationResponse.unreadCountDispute;
          mainVariables.notificationVariables.unreadCountChecklist = notificationResponse.unreadCountChecklist;
          emit(const NotificationDummy());
          emit(const NotificationLoaded());
        } else {
          emit(NotificationFailure(errorMessage: notificationResponse.message));
          emit(const NotificationLoading());
        }
      }
    });
  }

  FutureOr<void> readFunction(NotificationReadEvent event, Emitter<NotificationState> emit) async {
    await mainVariables.repoImpl.readNotification(notificationId: event.notificationId).onError((error, stackTrace) {
      emit(NotificationFailure(errorMessage: error.toString()));
      emit(const NotificationLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          if (mainVariables.notificationVariables.unreadCountAll > 0) mainVariables.notificationVariables.unreadCountAll--;
          switch (event.category) {
            case "transit":
              if (mainVariables.notificationVariables.unreadCountTransit > 0) mainVariables.notificationVariables.unreadCountTransit--;
            case "expiry":
              if (mainVariables.notificationVariables.unreadCountExpiry > 0) mainVariables.notificationVariables.unreadCountExpiry--;
            case "low_stock":
              if (mainVariables.notificationVariables.unreadCountLowStock > 0) mainVariables.notificationVariables.unreadCountLowStock--;
            case "stock_dispute":
              if (mainVariables.notificationVariables.unreadCountDispute > 0) mainVariables.notificationVariables.unreadCountDispute--;
            case "checklist":
              if (mainVariables.notificationVariables.unreadCountChecklist > 0) mainVariables.notificationVariables.unreadCountChecklist--;
            default:
              if (mainVariables.notificationVariables.unreadCountTransit > 0) mainVariables.notificationVariables.unreadCountTransit--;
          }
          emit(const NotificationLoading());
          emit(const NotificationLoaded());
        }
      }
    });
  }
}
