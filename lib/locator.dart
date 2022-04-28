import 'package:get_it/get_it.dart';
import 'package:pepper_house/controller/user_controller.dart';
import 'package:pepper_house/repository/cart_repo.dart';
import 'package:pepper_house/repository/menu_repo.dart';
import 'package:pepper_house/repository/order_repo.dart';
import 'package:pepper_house/repository/shared_ref.dart';
import 'package:pepper_house/services/fire_auth.dart';

final locator = GetIt.instance;
void setUpServices() {
  locator.registerSingleton<FireAuth>(FireAuth());
  locator.registerSingleton<UserController>(UserController());
  locator.registerSingleton<MenuRepository>(MenuRepository());
  locator.registerSingleton<SharedRefRepo>(SharedRefRepo());
  locator.registerSingleton<CartRepo>(CartRepo());
  locator.registerSingleton<OrderRepository>(OrderRepository());
   
}
