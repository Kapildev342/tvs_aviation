import 'package:tvsaviation/data/model/variable_model/add_dispute_variables.dart';
import 'package:tvsaviation/data/model/variable_model/check_list_variables.dart';
import 'package:tvsaviation/data/model/variable_model/code_verify_variables.dart';
import 'package:tvsaviation/data/model/variable_model/confirm_movement_variables.dart';
import 'package:tvsaviation/data/model/variable_model/create_password_variables.dart';
import 'package:tvsaviation/data/model/variable_model/forget_password_variables.dart';
import 'package:tvsaviation/data/model/variable_model/general_variables.dart';
import 'package:tvsaviation/data/model/variable_model/home_variables.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_variables.dart';
import 'package:tvsaviation/data/model/variable_model/login_variables.dart';
import 'package:tvsaviation/data/model/variable_model/manage_variables.dart';
import 'package:tvsaviation/data/model/variable_model/manual_variables.dart';
import 'package:tvsaviation/data/model/variable_model/notification_variables.dart';
import 'package:tvsaviation/data/model/variable_model/rail_navigation_variables.dart';
import 'package:tvsaviation/data/model/variable_model/received_stocks_variables.dart';
import 'package:tvsaviation/data/model/variable_model/reports_variables.dart';
import 'package:tvsaviation/data/model/variable_model/stock_dispute_variables.dart';
import 'package:tvsaviation/data/model/variable_model/stock_movement_variables.dart';
import 'package:tvsaviation/data/model/variable_model/transit_variables.dart';
import 'package:tvsaviation/data/repo/repo_impl.dart';

class Variables {
  GeneralVariables generalVariables = GeneralVariables.fromJson({});
  LoginVariables loginVariables = LoginVariables.fromJson({});
  ForgetPasswordVariables forgetPasswordVariables = ForgetPasswordVariables.fromJson({});
  CodeVerifyVariables codeVerifyVariables = CodeVerifyVariables.fromJson({});
  CreatePasswordVariables createPasswordVariables = CreatePasswordVariables.fromJson({});
  RailNavigationVariables railNavigationVariables = RailNavigationVariables.fromJson({});
  HomeVariables homeVariables = HomeVariables.fromJson({});
  InventoryVariables inventoryVariables = InventoryVariables.fromJson({});
  StockDisputeVariables stockDisputeVariables = StockDisputeVariables.fromJson({});
  ReportsVariables reportsVariables = ReportsVariables.fromJson({});
  CheckListVariables checkListVariables = CheckListVariables.fromJson({});
  ManageVariables manageVariables = ManageVariables.fromJson({});
  ManualVariables manualVariables = ManualVariables.fromJson({});
  NotificationVariables notificationVariables = NotificationVariables.fromJson({});
  ReceivedStocksVariables receivedStocksVariables = ReceivedStocksVariables.fromJson({});
  StockMovementVariables stockMovementVariables = StockMovementVariables.fromJson({});
  TransitVariables transitVariables = TransitVariables.fromJson({});
  ConfirmMovementVariables confirmMovementVariables = ConfirmMovementVariables.fromJson({});
  AddDisputeVariables addDisputeVariables = AddDisputeVariables.fromJson({});

  RepoImpl repoImpl = RepoImpl();
}
