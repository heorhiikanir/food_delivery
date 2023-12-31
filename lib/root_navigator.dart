import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/controllers/my_search_controller.dart';
import 'package:food_delivery/res/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/drawer_controller.dart';
import 'package:food_delivery/controllers/navigator_controller.dart';
import 'package:food_delivery/models/drawer_model.dart';
import 'package:food_delivery/res/dimentions.dart';
import 'package:food_delivery/views/screens/cart_screen/cart_screen.dart';
import 'package:get/get.dart';

import 'views/screens/history_screen/history_screen.dart';
import 'views/screens/home_screen/home_screen.dart';
import 'views/screens/liked_screen/liked_screen.dart';
import 'views/screens/profile_screen/profile_screen.dart';

class RootNavigator extends StatefulWidget {
  const RootNavigator({Key? key}) : super(key: key);

  @override
  _RootNavigatorState createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  // final SystemUiOverlayStyle _systemUiOverlayStyle = const SystemUiOverlayStyle(
  //   statusBarColor: AppColors.backgroundScreens,
  //   statusBarIconBrightness: Brightness.dark,
  //   systemNavigationBarColor: AppColors.backgroundScreens,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  //   systemNavigationBarDividerColor: AppColors.backgroundScreens,
  // );

  final _navigatorController = Get.find<NavigatorController>();
  final _drawerController = Get.find<MyDrawerController>();

  List<Widget> bottomNavScreens = const [
    HomeScreen(),
    LikedScreen(),
    ProfileScreen(),
    HistoryScreen()
  ];

  Widget appBar() {
    final _cartController = Get.find<CartController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            _drawerController.advancedDrawerController.showDrawer();
          },
          icon: SvgPicture.asset(
            'assets/icons/menu_icon.svg',
            width: 24,
            height: 24,
          ),
        ),
        Obx(
          () => badges.Badge(
            badgeColor: AppColors.primaryColor,
            position: badges.BadgePosition.topEnd(top: -5, end: -5),
            showBadge: _cartController.cartList.isNotEmpty,
            badgeContent: Text(
              _cartController.cartList.length.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            child: IconButton(
              onPressed: () {
                //Get.to(()=> const CartScreen());
                FocusScope.of(context).unfocus();
                Get.find<MySearchController>().searchBarController.clear();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CartScreen()));
              },
              icon: SvgPicture.asset('assets/icons/shopping-cart.svg',
                  width: 24, height: 24),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: AppColors.primaryColor,
      controller: _drawerController.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.7,
      openRatio: 1 / 2.2,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      drawer: buildDrawer(),
      child: scaffoldPage(bottomNavScreens),
    );
  }

  Scaffold scaffoldPage(List<Widget> screens) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBar(),
      ),
      body: Obx(
        () => IndexedStack(
          index: _navigatorController.navItemIndexSelected.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          backgroundColor: AppColors.backgroundScreens,
          currentIndex: _navigatorController.navItemIndexSelected.value,
          unselectedItemColor: Colors.grey.shade500,
          selectedItemColor: AppColors.primaryColor,
          iconSize: 32,
          onTap: (value) {
            _navigatorController.navItemIndexSelected.value = value;
            _navigatorController.changeNavItemIndex(
                _navigatorController.navItemIndexSelected.value);
          },
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: _navigatorController
                                        .navItemIndexSelected.value ==
                                    0
                                ? AppColors.primaryColor.withOpacity(0.3)
                                : Colors.transparent,
                            blurRadius: 12),
                      ]),
                  child: Icon(
                    _navigatorController.navItemIndexSelected.value == 0
                        ? Icons.home_rounded
                        : Icons.home_outlined,
                  ),
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: _navigatorController
                                        .navItemIndexSelected.value ==
                                    1
                                ? AppColors.primaryColor.withOpacity(0.3)
                                : Colors.transparent,
                            blurRadius: 12),
                      ]),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: _navigatorController
                                          .navItemIndexSelected.value ==
                                      1
                                  ? AppColors.primaryColor.withOpacity(0.3)
                                  : Colors.transparent,
                              blurRadius: 8),
                        ]),
                    child: Icon(
                      _navigatorController.navItemIndexSelected.value == 1
                          ? CupertinoIcons.suit_heart_fill
                          : CupertinoIcons.suit_heart,
                    ),
                  ),
                ),
                label: 'favourite'),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: _navigatorController
                                        .navItemIndexSelected.value ==
                                    2
                                ? AppColors.primaryColor.withOpacity(0.3)
                                : Colors.transparent,
                            blurRadius: 12),
                      ]),
                  child: Icon(
                    _navigatorController.navItemIndexSelected.value == 2
                        ? Icons.person
                        : Icons.person_outline,
                  ),
                ),
                label: 'profile'),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: _navigatorController
                                        .navItemIndexSelected.value ==
                                    3
                                ? AppColors.primaryColor.withOpacity(0.3)
                                : Colors.transparent,
                            blurRadius: 12),
                      ]),
                  child: const Icon(
                    Icons.history,
                  ),
                ),
                label: 'history'),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.1,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: drawerList.length - 1,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
                      _drawerController.changeDrawerItemIndex(index);
                      switch (_drawerController.drawerItemIndex.value) {
                        case 0:
                          _navigatorController.changeNavItemIndex(2);
                          _drawerController.advancedDrawerController.hideDrawer();
                          //Get.to(()=> const ProfileScreen());
                          break;
                
                        case 1:
                          _drawerController.advancedDrawerController.hideDrawer();
                          Get.to(() => const CartScreen());
                          break;
                
                        case 2:
                          break;
                
                        case 3:
                          break;
                
                        case 4:
                          break;
                
                        case 5:
                          break;
                      }
                    },
                    horizontalTitleGap: 0,
                    title: Text(
                      drawerList[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                    leading: SvgPicture.asset(
                      drawerList[index].iconPath,
                      color: Colors.white,
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 2,
                  indent: 60,
                );
              },
            ),
          ),
          SizedBox(height: AppDimens.bodyMarginLarge,),
          InkWell(
            onTap: () {
              _drawerController.changeDrawerItemIndex(drawerList.length);
            },
            child: Padding(
              padding: EdgeInsets.all(AppDimens.bodyMarginLarge),
              child: Row(
                children: [
                  Text(
                    drawerList.last.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    width: AppDimens.bodyMarginSmall,
                  ),
                  SvgPicture.asset(
                    drawerList.last.iconPath,
                    color: Colors.white,
                  )
                  //Icon(drawerList.last.icon,color: Colors.white,),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.2,
          ),
        ],
      ),
    );
  }
}
