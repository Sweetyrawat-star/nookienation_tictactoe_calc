

import '../screens/gamehistory.dart';
import '../screens/home_screen.dart';
import '../screens/leaderboard.dart';
import '../screens/login.dart';
import '../screens/profile.dart';
import '../screens/shop.dart';
import '../screens/skins.dart';
import '../screens/splash.dart';

class Routes {
  static final data = {
    "/authscreen": (context) => Login(),
    "/home": (context) => HomeScreenActivity(),
    "/splash": (context) => SplashScreen(),
    "/leaderboard": (context) => LeaderBoardScreen(),
    "/profile": (context) => Profile(),
    "/shop": (context) => ShopScreen(),
    "/skin": (context) => Skins(),
    "/gamehistory": (context) => GameHistory(),

  };
}
