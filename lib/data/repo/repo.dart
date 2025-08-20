import 'dart:io';

abstract class Repo {
  Future<dynamic> getLogin({required String userName, required String password, required String fcmToken}) async {}
  Future<dynamic> getLogout() async {}
  Future<dynamic> sendOtp({required String email}) async {}
  Future<dynamic> otpValidation({required String email, required String otp}) async {}
  Future<dynamic> sendOtpResend({required String email}) async {}
  Future<dynamic> createPassword({required String email, required String password}) async {}
  Future<dynamic> getLocation() async {}
  Future<dynamic> getNotification({required String locationId, required String category}) async {}
  Future<dynamic> getNotificationCount() async {}
  Future<dynamic> readNotification({required String notificationId}) async {}
  Future<dynamic> getCrew() async {}
  Future<dynamic> getHandler() async {}
  Future<dynamic> getSector() async {}
  Future<dynamic> getCategory() async {}
  Future<dynamic> getInventoryCategory({required Map<String, dynamic> query}) async {}
  Future<dynamic> getInventory({required Map<String, dynamic> query}) async {}
  Future<dynamic> getCheckList({required Map<String, dynamic> query}) async {}
  Future<dynamic> createStockMovement({required Map<String, dynamic> query}) async {}
  Future<dynamic> getAllTransit({required Map<String, dynamic> query}) async {}
  Future<dynamic> getSingleTransit({required Map<String, dynamic> query}) async {}
  Future<dynamic> confirmStockMovement({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> editProfileFunction({required Map<String, dynamic> query, required Map<String, File> files}) async {}
  Future<dynamic> changePasswordFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> overAllFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsOverallDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> lowStockFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsLowStockDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> expiryFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsExpiryDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> transactionFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsTransactionDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> cabinGalleyFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsCabinGalleyDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> checkListFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsCheckListDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> stockDisputeFunction({required Map<String, dynamic> query}) async {}
  Future<dynamic> fileReportsStockDisputeDownload({required Map<String, dynamic> query}) async {}
  Future<dynamic> filePdfDownload() async {}
  Future<dynamic> filePdfUpload({required Map<String, File> files}) async {}
  Future<dynamic> fileCsvUpload({required Map<String, File> files}) async {}
  Future<dynamic> getInventoryProductsList({required Map<String, dynamic> query}) async {}
  Future<dynamic> getProductTransitList({required Map<String, dynamic> query}) async {}
  Future<dynamic> productCountByLocation({required Map<String, dynamic> query}) async {}
  Future<dynamic> productDetailsByProduct({required Map<String, dynamic> query}) async {}
  Future<dynamic> shortageDetailsByProduct({required Map<String, dynamic> query}) async {}
  Future<dynamic> minimumLevelUpdate({required Map<String, dynamic> query}) async {}
  Future<dynamic> quantityUpdate({required Map<String, dynamic> query}) async {}
  Future<dynamic> getBrandTypeList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addBrandType({required Map<String, dynamic> query}) async {}
  Future<dynamic> deleteBrandType({required Map<String, dynamic> query}) async {}
  Future<dynamic> editBrandType({required Map<String, dynamic> query}) async {}
  Future<dynamic> getCategoriesList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addCategory({required Map<String, dynamic> query}) async {}
  Future<dynamic> deleteCategory({required Map<String, dynamic> query}) async {}
  Future<dynamic> editCategory({required Map<String, dynamic> query}) async {}
  Future<dynamic> getHandlerList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addHandler({required Map<String, dynamic> query}) async {}
  Future<dynamic> deleteHandler({required Map<String, dynamic> query}) async {}
  Future<dynamic> editHandler({required Map<String, dynamic> query}) async {}
  Future<dynamic> getWarehouseOrAircraftList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addWarehouseOrAircraft({required Map<String, dynamic> query}) async {}
  Future<dynamic> deleteWarehouseOrAircraft({required Map<String, dynamic> query}) async {}
  Future<dynamic> editWarehouseOrAircraft({required Map<String, dynamic> query}) async {}
  Future<dynamic> getSectorList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addSector({required Map<String, dynamic> query}) async {}
  Future<dynamic> deleteSector({required Map<String, dynamic> query}) async {}
  Future<dynamic> editSector({required Map<String, dynamic> query}) async {}
  Future<dynamic> getCrewList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addCrew({required Map<String, dynamic> query}) async {}
  Future<dynamic> deleteCrew({required Map<String, dynamic> query}) async {}
  Future<dynamic> editCrew({required Map<String, dynamic> query}) async {}
  Future<dynamic> activateCrew({required Map<String, dynamic> query}) async {}
  Future<dynamic> deactivateCrew({required Map<String, dynamic> query}) async {}
  Future<dynamic> getAllCategory() async {}
  Future<dynamic> getAllBrand() async {}
  Future<dynamic> getAllProductBrand() async {}
  Future<dynamic> getProductsList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addProduct({required Map<String, dynamic> query, required Map<String, File> files}) async {}
  Future<dynamic> deleteProduct({required Map<String, dynamic> query}) async {}
  Future<dynamic> editProduct({required Map<String, dynamic> query, required Map<String, File> files}) async {}
  Future<dynamic> activateProduct({required Map<String, dynamic> query}) async {}
  Future<dynamic> deactivateProduct({required Map<String, dynamic> query}) async {}
  Future<dynamic> productMiniLevelExpiry({required Map<String, dynamic> query}) async {}
  Future<dynamic> addInventory({required Map<String, dynamic> query}) async {}
  Future<dynamic> addCheckList({required Map<String, dynamic> query}) async {}
  Future<dynamic> addDispute({required Map<String, dynamic> query}) async {}
  Future<dynamic> getDisputeDetails({required Map<String, dynamic> query}) async {}
  Future<dynamic> disputeAdminComment({required Map<String, dynamic> query}) async {}
  Future<dynamic> getSingleCheckListDetail({required Map<String, dynamic> query}) async {}
  Future<dynamic> getProduct({required Map<String, dynamic> query}) async {}
  Future<dynamic> getCart({required Map<String, dynamic> query}) async {}
  Future<dynamic> updateCart({required Map<String, dynamic> query}) async {}
  Future<dynamic> cartAction({required Map<String, dynamic> query}) async {}
}
