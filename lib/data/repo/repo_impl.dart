import 'dart:io';
import 'package:tvsaviation/data/remote/api_end_points.dart';
import 'package:tvsaviation/data/remote/base_api_service.dart';
import 'package:tvsaviation/data/remote/network_api_service.dart';
import 'package:tvsaviation/data/repo/repo.dart';

class RepoImpl implements Repo {
  final BaseApiService apiService = NetworkApiService();

  @override
  Future<dynamic> getLogin({required String userName, required String password, required String fcmToken}) async {
    try {
      dynamic response = await apiService.getLogin(url: ApiEndPoints().login, userName: userName, password: password, fcmToken: fcmToken);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getLogout() async {
    try {
      dynamic response = await apiService.getLogout(url: ApiEndPoints().logout);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendOtp({required String email}) async {
    try {
      dynamic response = await apiService.sendOtp(url: ApiEndPoints().forgetPassword, email: email);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> otpValidation({required String email, required String otp}) async {
    try {
      dynamic response = await apiService.otpValidation(url: ApiEndPoints().verification, email: email, otp: otp);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> sendOtpResend({required String email}) async {
    try {
      dynamic response = await apiService.sendOtpResend(url: ApiEndPoints().verificationResend, email: email);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> createPassword({required String email, required String password}) async {
    try {
      dynamic response = await apiService.createPassword(url: ApiEndPoints().createNewPassword, email: email, password: password);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getLocation() async {
    try {
      dynamic response = await apiService.getLocation(url: ApiEndPoints().getLocation);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getNotification({required String locationId, required String category}) async {
    try {
      dynamic response = await apiService.getNotification(url: ApiEndPoints().getNotification, locationId: locationId, category: category);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getNotificationCount() async {
    try {
      dynamic response = await apiService.getNotificationCount(url: ApiEndPoints().getNotificationCount);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> readNotification({required String notificationId}) async {
    try {
      dynamic response = await apiService.readNotification(url: ApiEndPoints().notificationRead, notificationId: notificationId);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getSector() async {
    try {
      dynamic response = await apiService.getSector(url: ApiEndPoints().getSector);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getHandler() async {
    try {
      dynamic response = await apiService.getHandler(url: ApiEndPoints().getHandler);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCrew() async {
    try {
      dynamic response = await apiService.getCrew(url: ApiEndPoints().getCrew);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCategory() async {
    try {
      dynamic response = await apiService.getCategory(url: ApiEndPoints().getCategory);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getInventoryCategory({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getInventoryCategory(url: ApiEndPoints().getInventoryCategory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getInventory({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getInventory(url: ApiEndPoints().getInventory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCheckList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getCheckList(url: ApiEndPoints().getCheckList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> createStockMovement({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.createStockMovement(url: ApiEndPoints().createStockMovement, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getAllTransit({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getAllTransit(url: ApiEndPoints().getTransit, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getSingleTransit({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getSingleTransit(url: ApiEndPoints().getSingleTransit, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> confirmStockMovement({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.confirmStockMovement(url: ApiEndPoints().confirmStockMovement, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileDownload(url: ApiEndPoints().fileDownload, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editProfileFunction({required Map<String, dynamic> query, required Map<String, File> files}) async {
    try {
      dynamic response = await apiService.editProfileFunction(url: ApiEndPoints().editProfile, query: query, files: files);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> changePasswordFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.changePasswordFunction(url: ApiEndPoints().changePassword, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> overAllFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().overAllStockReport, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsOverallDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().overAllStockCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> lowStockFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().lowStockReport, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsLowStockDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().lowStockCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> expiryFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().expiryReport, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsExpiryDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().expiryCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> transactionFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().transactionHistory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsTransactionDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().transactionHistoryCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> cabinGalleyFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().cabinGalleyReport, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsCabinGalleyDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().cabinGalleyCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> checkListFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().checklistReport, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsCheckListDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().checklistCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> stockDisputeFunction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.reportsMainFunction(url: ApiEndPoints().stockDisputeReport, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileReportsStockDisputeDownload({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.fileReportsDownload(url: ApiEndPoints().stockDisputeCSV, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> filePdfDownload() async {
    try {
      dynamic response = await apiService.filePdfDownload(url: ApiEndPoints().filePdfDownload);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> filePdfUpload({required Map<String, File> files}) async {
    try {
      dynamic response = await apiService.filePdfUpload(url: ApiEndPoints().filePdfUpload, files: files);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> fileCsvUpload({required Map<String, File> files}) async {
    try {
      dynamic response = await apiService.fileCsvUpload(url: ApiEndPoints().fileCsvUpload, files: files);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getInventoryProductsList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getInventoryProductsList(url: ApiEndPoints().getInventoryProductsList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getProductTransitList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getProductTransitList(url: ApiEndPoints().getProductTransitList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> productCountByLocation({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.productCountByLocation(url: ApiEndPoints().productCountByLocation, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> productDetailsByProduct({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.productDetailsByProduct(url: ApiEndPoints().productDetailsByProduct, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> shortageDetailsByProduct({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.shortageDetailsByProduct(url: ApiEndPoints().shortageDetailsByProduct, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> quantityUpdate({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.quantityUpdate(url: ApiEndPoints().quantityUpdate, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> minimumLevelUpdate({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.minimumLevelUpdate(url: ApiEndPoints().minimumLevelUpdate, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getBrandTypeList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getBrandTypeList(url: ApiEndPoints().getBrandTypeList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addBrandType({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addBrandType(url: ApiEndPoints().addBrandType, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteBrandType({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteBrandType(url: ApiEndPoints().deleteBrandType, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editBrandType({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.editBrandType(url: ApiEndPoints().editBrandType, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCategoriesList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getCategoriesList(url: ApiEndPoints().getCategoriesList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addCategory({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addCategory(url: ApiEndPoints().addCategory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteCategory({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteCategory(url: ApiEndPoints().deleteCategory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editCategory({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.editCategory(url: ApiEndPoints().editCategory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getHandlerList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getHandlerList(url: ApiEndPoints().getHandlerList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addHandler({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addHandler(url: ApiEndPoints().addHandler, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteHandler({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteHandler(url: ApiEndPoints().deleteHandler, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editHandler({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.editHandler(url: ApiEndPoints().editHandler, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getWarehouseOrAircraftList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getWarehouseOrAircraftList(url: ApiEndPoints().getWarehouseOrAircraftList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addWarehouseOrAircraft({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addWarehouseOrAircraft(url: ApiEndPoints().addWarehouseOrAircraft, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteWarehouseOrAircraft({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteWarehouseOrAircraft(url: ApiEndPoints().deleteWarehouseOrAircraft, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editWarehouseOrAircraft({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.editWarehouseOrAircraft(url: ApiEndPoints().editWarehouseOrAircraft, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getSectorList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getSectorList(url: ApiEndPoints().getSectorList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addSector({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addSector(url: ApiEndPoints().addSector, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteSector({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteSector(url: ApiEndPoints().deleteSector, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editSector({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.editSector(url: ApiEndPoints().editSector, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCrewList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getCrewList(url: ApiEndPoints().getCrewList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addCrew({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addCrew(url: ApiEndPoints().addCrew, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteCrew({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteCrew(url: ApiEndPoints().deleteCrew, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editCrew({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.editCrew(url: ApiEndPoints().editCrew, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> activateCrew({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.activateCrew(url: ApiEndPoints().activateCrew, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deactivateCrew({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deactivateCrew(url: ApiEndPoints().deactivateCrew, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getAllCategory() async {
    try {
      dynamic response = await apiService.getAllCategory(url: ApiEndPoints().getAllCategory);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getAllBrand() async {
    try {
      dynamic response = await apiService.getAllBrand(url: ApiEndPoints().getAllBrand);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getAllProductBrand() async {
    try {
      dynamic response = await apiService.getAllProductBrand(url: ApiEndPoints().getAllProductBrand);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getProductsList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getProductsList(url: ApiEndPoints().getProductsList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addProduct({required Map<String, dynamic> query, required Map<String, File> files}) async {
    try {
      dynamic response = await apiService.addProduct(url: ApiEndPoints().addProduct, query: query, files: files);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteProduct({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deleteProduct(url: ApiEndPoints().deleteProduct, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> editProduct({required Map<String, dynamic> query, required Map<String, File> files}) async {
    try {
      dynamic response = await apiService.editProduct(url: ApiEndPoints().editProduct, query: query, files: files);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> activateProduct({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.activateProduct(url: ApiEndPoints().activateProduct, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deactivateProduct({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.deactivateProduct(url: ApiEndPoints().deactivateProduct, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> productMiniLevelExpiry({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.productMiniLevelExpiry(url: ApiEndPoints().productMiniLevelExpiry, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addInventory({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addInventory(url: ApiEndPoints().addInventory, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addCheckList({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addCheckList(url: ApiEndPoints().addCheckList, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> addDispute({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.addDispute(url: ApiEndPoints().addDispute, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getDisputeDetails({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getDisputeDetails(url: ApiEndPoints().getDisputeDetails, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> disputeAdminComment({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.disputeAdminComment(url: ApiEndPoints().disputeAdminComment, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getSingleCheckListDetail({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getSingleCheckListDetail(url: ApiEndPoints().getSingleCheckListDetails, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getProduct({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getProduct(url: ApiEndPoints().getProduct, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getCart({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.getCart(url: ApiEndPoints().getCart, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> updateCart({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.updateCart(url: ApiEndPoints().updateCart, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> cartAction({required Map<String, dynamic> query}) async {
    try {
      dynamic response = await apiService.cartAction(url: ApiEndPoints().cartAction, query: query);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
