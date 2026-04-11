import 'package:digital_event/fetures/wallet/screen/wallet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../favorites/screen/favorite_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../trip_plan/screen/trip_plan_screen.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;


  final List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const TripPlanScreen(),
    const WalletScreen(),
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }

}
