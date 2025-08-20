import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tvsaviation/bloc/add_dispute/add_dispute_bloc.dart';
import 'package:tvsaviation/bloc/confirm_movement/confirm_movement_bloc.dart';
import 'package:tvsaviation/bloc/received_stocks/received_stocks_bloc.dart';
import 'package:tvsaviation/bloc/stock_dispute/stock_dispute_bloc.dart';
import 'package:tvsaviation/data/hive/user/user_data.dart';
import 'package:tvsaviation/data/model/api_model/edit_profile_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/ui/check_list/check_list_screen.dart';
import 'package:tvsaviation/ui/home/home_screen.dart';
import 'package:tvsaviation/ui/inventory/inventory_screen.dart';
import 'package:tvsaviation/ui/manage/manage_screen.dart';
import 'package:tvsaviation/ui/manual/manual_screen.dart';
import 'package:tvsaviation/ui/notification/notification_screen.dart';
import 'package:tvsaviation/ui/received_stocks/received_stocks_screen.dart';
import 'package:tvsaviation/ui/reports/reports.dart';
import 'package:tvsaviation/ui/stock_dispute/add_dispute_screen.dart';
import 'package:tvsaviation/ui/stock_dispute/stock_dispute_screen.dart';
import 'package:tvsaviation/ui/stock_movement/confirm_movement.dart';
import 'package:tvsaviation/ui/stock_movement/stock_movement.dart';
import 'package:tvsaviation/ui/transit/transit.dart';

part 'rail_navigation_event.dart';
part 'rail_navigation_state.dart';

class RailNavigationBloc extends Bloc<RailNavigationEvent, RailNavigationState> {
  RailNavigationBloc() : super(RailNavigationLoaded()) {
    on<RailNavigationInitialEvent>(getInitialWidget);
    on<RailNavigationSelectedWidgetEvent>(getSelectedWidget);
    on<RailNavigationBackWidgetEvent>(getBackWidget);
    on<EditProfileEvent>(editProfileFunction);
    on<PasswordToggleEvent>(passwordToggleFunction);
  }

  Future<void> getInitialWidget(RailNavigationInitialEvent event, Emitter<RailNavigationState> emit) async {
    event.modelSetState(() {});
    emit(RailNavigationLoaded());
  }

  Future<void> getSelectedWidget(RailNavigationSelectedWidgetEvent event, Emitter<RailNavigationState> emit) async {
    switch (mainVariables.generalVariables.railNavigateIndex) {
      case 0:
        {
          mainVariables.generalVariables.mainScreenWidget = const HomeScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 1:
        {
          mainVariables.generalVariables.mainScreenWidget = const InventoryScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 2:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => StockDisputeBloc(), child: const StockDisputeScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 3:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => StockDisputeBloc(), child: const StockDisputeScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 4:
        {
          mainVariables.generalVariables.mainScreenWidget = const ReportsScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 5:
        {
          mainVariables.generalVariables.mainScreenWidget = const CheckListScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 6:
        {
          mainVariables.generalVariables.mainScreenWidget = const ManageScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 7:
        {
          mainVariables.generalVariables.mainScreenWidget = const ManualScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 8:
        {
          mainVariables.generalVariables.mainScreenWidget = const NotificationScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 9:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => ReceivedStocksBloc(), child: const ReceivedStocksScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 10:
        {
          mainVariables.generalVariables.mainScreenWidget = const StockMovementScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 11:
        {
          mainVariables.generalVariables.mainScreenWidget = const TransitScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 12:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => ConfirmMovementBloc(), child: const ConfirmMovementScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 13:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => AddDisputeBloc(), child: const AddDisputeScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      default:
        {
          mainVariables.generalVariables.mainScreenWidget = const HomeScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
    }
  }

  Future<void> getBackWidget(RailNavigationBackWidgetEvent event, Emitter<RailNavigationState> emit) async {
    switch (mainVariables.generalVariables.railNavigateBackIndex) {
      case 0:
        {
          mainVariables.generalVariables.mainScreenWidget = const HomeScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 1:
        {
          mainVariables.generalVariables.mainScreenWidget = const InventoryScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 2:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => StockDisputeBloc(), child: const StockDisputeScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 3:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => StockDisputeBloc(), child: const StockDisputeScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 4:
        {
          mainVariables.generalVariables.mainScreenWidget = const ReportsScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 5:
        {
          mainVariables.generalVariables.mainScreenWidget = const CheckListScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 6:
        {
          mainVariables.generalVariables.mainScreenWidget = const ManageScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 7:
        {
          mainVariables.generalVariables.mainScreenWidget = const ManualScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 8:
        {
          mainVariables.generalVariables.mainScreenWidget = const NotificationScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 9:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => ReceivedStocksBloc(), child: const ReceivedStocksScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 10:
        {
          mainVariables.generalVariables.mainScreenWidget = const StockMovementScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 11:
        {
          mainVariables.generalVariables.mainScreenWidget = const TransitScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 12:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => ConfirmMovementBloc(), child: const ConfirmMovementScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      case 13:
        {
          mainVariables.generalVariables.mainScreenWidget = BlocProvider(create: (context) => AddDisputeBloc(), child: const AddDisputeScreen());
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
      default:
        {
          mainVariables.generalVariables.mainScreenWidget = const HomeScreen();
          emit(RailNavigationDummy());
          emit(RailNavigationLoaded());
        }
    }
  }

  FutureOr<void> editProfileFunction(EditProfileEvent event, Emitter<RailNavigationState> emit) async {
    await mainVariables.repoImpl.editProfileFunction(query: {
      "firstName": mainVariables.homeVariables.firstNameController.text,
      "lastName": mainVariables.homeVariables.lastNameController.text,
      "email": mainVariables.homeVariables.mailController.text,
    }, files: {
      "profileImage": mainVariables.homeVariables.selectedImage ?? File("")
    }).onError((error, stackTrace) {
      emit(RailNavigationFailure(errorMessage: error.toString()));
      emit(RailNavigationLoaded());
    }).then((value) async {
      if (value != null) {
        EditProfileModel editProfile = EditProfileModel.fromJson(value);
        if (editProfile.status) {
          mainVariables.generalVariables.userData = editProfile.updatedUser;
          var box = await Hive.openBox('boxData');
          box.clear();
          UserResponse userResponse = UserResponse(
            token: mainVariables.generalVariables.userToken,
            user: User(
              id: editProfile.updatedUser.id,
              firstName: editProfile.updatedUser.firstName,
              lastName: editProfile.updatedUser.lastName,
              email: editProfile.updatedUser.email,
              role: editProfile.updatedUser.role,
              createdAt: DateTime.parse("${editProfile.updatedUser.createdAt}"),
              updatedAt: DateTime.parse("${editProfile.updatedUser.updatedAt}"),
              activeStatus: editProfile.updatedUser.activeStatus,
              verificationCode: editProfile.updatedUser.verificationCode,
              verificationCodeExpiry: DateTime.parse("${editProfile.updatedUser.verificationCodeExpiry}"),
              profilePhoto: editProfile.updatedUser.profilePhoto,
            ),
            status: editProfile.status,
          );
          await box.put('user_response', userResponse);
          emit(const RailNavigationSuccess(message: "Profile updated successfully"));
          emit(RailNavigationLoaded());
        } else {
          emit(const RailNavigationFailure(errorMessage: "Something went wrong"));
          emit(RailNavigationLoaded());
        }
      } else {
        emit(const RailNavigationFailure(errorMessage: "Something went wrong"));
        emit(RailNavigationLoaded());
      }
    });
  }

  FutureOr<void> passwordToggleFunction(PasswordToggleEvent event, Emitter<RailNavigationState> emit) async {
    switch (event.type) {
      case "current":
        {
          mainVariables.homeVariables.currentPasswordObscure = !mainVariables.homeVariables.currentPasswordObscure;
        }
      case "new":
        {
          mainVariables.homeVariables.newPasswordObscure = !mainVariables.homeVariables.newPasswordObscure;
        }
      case "confirm":
        {
          mainVariables.homeVariables.confirmPasswordObscure = !mainVariables.homeVariables.confirmPasswordObscure;
        }
      default:
        {}
    }
  }
}
