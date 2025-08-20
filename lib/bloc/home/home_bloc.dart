import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tvsaviation/data/hive/category/category_data.dart';
import 'package:tvsaviation/data/hive/crew/crew_data.dart';
import 'package:tvsaviation/data/hive/handler/handler_data.dart';
import 'package:tvsaviation/data/hive/location/location_data.dart';
import 'package:tvsaviation/data/hive/sector/sector_data.dart';
import 'package:tvsaviation/data/hive/stock_type/stock_type_data.dart';
import 'package:tvsaviation/data/hive/user/user_data.dart';
import 'package:tvsaviation/data/model/api_model/get_category_response_model.dart';
import 'package:tvsaviation/data/model/api_model/get_crew_model.dart';
import 'package:tvsaviation/data/model/api_model/get_handler_model.dart';
import 'package:tvsaviation/data/model/api_model/get_location_model.dart';
import 'package:tvsaviation/data/model/api_model/get_sector_model.dart';
import 'package:tvsaviation/data/model/api_model/get_stock_type_model.dart';
import 'package:tvsaviation/data/model/api_model/notification_count_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoading()) {
    on<HomeInitialEvent>(initialFunction);
  }

  FutureOr<void> initialFunction(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    mainVariables.homeVariables.loader = true;
    mainVariables.inventoryVariables.tabControllerIndex = 0;
    mainVariables.generalVariables.railNavigateBackIndex = 0;
    mainVariables.generalVariables.railNavigateIndex = 0;
    mainVariables.railNavigationVariables.mainSelectedIndex = 0;
    mainVariables.homeVariables.homeLocationSelectedIndex = -1;
    mainVariables.stockMovementVariables.senderInfo.locationDropDownList.clear();
    mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.clear();
    mainVariables.stockMovementVariables.receiverInfo.crewDropDownList.clear();
    mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.clear();
    mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.clear();
    var userBox = await Hive.openBox('boxData');
    if (userBox.values.isNotEmpty) {
      UserResponse data = userBox.get("user_response");
      mainVariables.generalVariables.userToken = data.token;
      mainVariables.generalVariables.userData = data.user;
    } else {}
    await mainVariables.repoImpl.getNotificationCount().onError((error, stackTrace) {}).then((value) async {
      if (value != null) {
        mainVariables.homeVariables.locationIdList.clear();
        mainVariables.homeVariables.locationList.clear();
        mainVariables.homeVariables.locationCountList.clear();
        NotificationCountModel notificationCounts = NotificationCountModel.fromJson(value);
        for (int i = 0; i < notificationCounts.locationCounts.length; i++) {
          mainVariables.homeVariables.locationIdList.add(notificationCounts.locationCounts[i].id);
          mainVariables.homeVariables.locationList.add(notificationCounts.locationCounts[i].name);
          mainVariables.homeVariables.locationCountList.add(notificationCounts.locationCounts[i].count);
        }
        mainVariables.homeVariables.badgeNotifyCount = notificationCounts.totalUnreadCount;
      }
    });
   // var locationBox = await Hive.openBox<LocationResponse>('locations');
   /* if (locationBox.values.isNotEmpty) {
      mainVariables.stockMovementVariables.senderInfo.locationDropDownList = List<DropDownValueModel>.generate(
        locationBox.values.length,
        (index) => DropDownValueModel(
          name: (locationBox.getAt(index) ?? LocationResponse.fromJson({})).name,
          value: (locationBox.getAt(index) ?? LocationResponse.fromJson({})).id,
        ),
      );
    } else {*/
      await mainVariables.repoImpl.getLocation().onError((error, stackTrace) {
        emit(HomeFailure(errorMessage: error.toString()));
        emit(const HomeLoading());
      }).then((value) async {if (value != null) {
          GetLocationModel getLocationResponse = GetLocationModel.fromJson(value);
          if (getLocationResponse.status) {
            final box = Hive.box<LocationResponse>('locations');
            for (int i = 0; i < getLocationResponse.locations.length; i++) {
              await box.put(getLocationResponse.locations[i].id, getLocationResponse.locations[i]);
              mainVariables.stockMovementVariables.senderInfo.locationDropDownList.add(DropDownValueModel(
                name: getLocationResponse.locations[i].name,
                value: getLocationResponse.locations[i].id,
              ));
            }
          } else {
            emit(HomeFailure(errorMessage: getLocationResponse.message));
            emit(const HomeLoading());
          }
        }});
    //}
    //var stockTypeBox = await Hive.openBox<StockTypeResponse>('stockType');
   // if (stockTypeBox.values.isEmpty) {
      GetStockTypeModel getStockType = GetStockTypeModel.fromJson({});
      final box = Hive.box<StockTypeResponse>('stockType');
      for (int i = 0; i < getStockType.stockType.length; i++) {
        await box.put(getStockType.stockType[i].id, getStockType.stockType[i]);
        mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.add(
          DropDownValueModel(
            name: getStockType.stockType[i].name,
            value: getStockType.stockType[i].id,
          ),
        );
      }
   /* } else {
      mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList = List<DropDownValueModel>.generate(
        stockTypeBox.values.length,
        (index) => DropDownValueModel(
          name: (stockTypeBox.getAt(index) ?? StockTypeResponse.fromJson({})).name,
          value: (stockTypeBox.getAt(index) ?? StockTypeResponse.fromJson({})).id,
        ),
      );
    }*/
    //var categoryBox = await Hive.openBox<CategoryResponse>('category');
    //if (categoryBox.values.isEmpty) {
      mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.clear();
      await mainVariables.repoImpl.getCategory().onError((error, stackTrace) {}).then((value) async {
        if (value != null) {
          GetCategoryResponseModel getCategoryType = GetCategoryResponseModel.fromJson(value);
          final box = Hive.box<CategoryResponse>('category');
          for (int i = 0; i < getCategoryType.categoryResponse.length; i++) {
            await box.put(getCategoryType.categoryResponse[i].id, getCategoryType.categoryResponse[i]);
            mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.add(
              DropDownValueModel(
                name: getCategoryType.categoryResponse[i].name.toLowerCase().capitalizeFirst!,
                value: getCategoryType.categoryResponse[i].id,
              ),
            );
          }
        }
      });
    /*} else {
      mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.clear();
      mainVariables.stockMovementVariables.senderInfo.categoryDropDownList = List<DropDownValueModel>.generate(
        categoryBox.values.length,
        (index) => DropDownValueModel(
          name: (categoryBox.getAt(index) ?? CategoryResponse.fromJson({})).name.toLowerCase().capitalizeFirst!,
          value: (categoryBox.getAt(index) ?? CategoryResponse.fromJson({})).id,
        ),
      );
    }*/
    //var crewBox = await Hive.openBox<CrewResponse>('crew');
    //if (crewBox.values.isEmpty) {
      await mainVariables.repoImpl.getCrew().onError((error, stackTrace) {}).then((value) async {
        if (value != null) {
          GetCrewModel getCrewResponse = GetCrewModel.fromJson(value);
          if (getCrewResponse.status) {
            final box = Hive.box<CrewResponse>('crew');
            for (int i = 0; i < getCrewResponse.crews.length; i++) {
              await box.put(getCrewResponse.crews[i].firstName, getCrewResponse.crews[i]);
              mainVariables.stockMovementVariables.receiverInfo.crewDropDownList.add(
                DropDownValueModel(
                  name: "${getCrewResponse.crews[i].firstName} ${getCrewResponse.crews[i].lastName}",
                  value: getCrewResponse.crews[i].id,
                ),
              );
            }
          }
        }
      });
    /*} else {
      mainVariables.stockMovementVariables.receiverInfo.crewDropDownList = List<DropDownValueModel>.generate(
        crewBox.values.length,
        (index) => DropDownValueModel(
          name: (crewBox.getAt(index) ?? CrewResponse.fromJson({})).firstName,
          value: (crewBox.getAt(index) ?? CrewResponse.fromJson({})).id,
        ),
      );
    }*/
    //var sectorBox = await Hive.openBox<SectorResponse>('sector');
    //if (sectorBox.values.isEmpty) {
      await mainVariables.repoImpl.getSector().onError((error, stackTrace) {}).then((value) async {
        if (value != null) {
          GetSectorModel getSectorResponse = GetSectorModel.fromJson(value);
          if (getSectorResponse.status) {
            final box = Hive.box<SectorResponse>('sector');
            for (int i = 0; i < getSectorResponse.sectors.length; i++) {
              await box.put(getSectorResponse.sectors[i].id, getSectorResponse.sectors[i]);
              mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.add(
                DropDownValueModel(
                  name: getSectorResponse.sectors[i].icao,
                  value: getSectorResponse.sectors[i].id,
                  iata: getSectorResponse.sectors[i].iata,
                  airportName: getSectorResponse.sectors[i].airportName,
                  city: getSectorResponse.sectors[i].city,
                ),
              );
            }
          }
        }
      });
    /*} else {
      mainVariables.stockMovementVariables.senderInfo.sectorDropDownList = List<DropDownValueModel>.generate(
        sectorBox.values.length,
        (index) => DropDownValueModel(
          name: (sectorBox.getAt(index) ?? SectorResponse.fromJson({})).icao,
          value: (sectorBox.getAt(index) ?? SectorResponse.fromJson({})).id,
          iata: (sectorBox.getAt(index) ?? SectorResponse.fromJson({})).iata,
          airportName: (sectorBox.getAt(index) ?? SectorResponse.fromJson({})).airportName,
          city: (sectorBox.getAt(index) ?? SectorResponse.fromJson({})).city,
        ),
      );
    }*/
   // var handlerBox = await Hive.openBox<HandlerResponse>('handler');
    //if (handlerBox.values.isEmpty) {
      await mainVariables.repoImpl.getHandler().onError((error, stackTrace) {}).then((value) async {
        if (value != null) {
          GetHandlerModel getHandlerResponse = GetHandlerModel.fromJson(value);
          if (getHandlerResponse.status) {
            final box = Hive.box<HandlerResponse>('handler');
            for (int i = 0; i < getHandlerResponse.handlers.length; i++) {
              await box.put(getHandlerResponse.handlers[i].id, getHandlerResponse.handlers[i]);
              mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.add(
                DropDownValueModel(
                  name: getHandlerResponse.handlers[i].name,
                  value: getHandlerResponse.handlers[i].id,
                ),
              );
            }
            emit(const HomeDummy());
            emit(const HomeLoaded());
          }
        }
      });
    /*} else {
      mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList = List<DropDownValueModel>.generate(
        handlerBox.values.length,
        (index) => DropDownValueModel(
          name: (handlerBox.getAt(index) ?? HandlerResponse.fromJson({})).name,
          value: (handlerBox.getAt(index) ?? HandlerResponse.fromJson({})).id,
        ),
      );
      emit(const HomeDummy());
      emit(const HomeLoaded());
    }*/
  }
}
