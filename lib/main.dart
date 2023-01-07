import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:epiece_shopping_app/controllers/auth_controller.dart';
import 'package:epiece_shopping_app/controllers/cart_controller.dart';
import 'package:epiece_shopping_app/controllers/popular_product.dart';
import 'package:epiece_shopping_app/controllers/product_controller.dart';
import 'package:epiece_shopping_app/controllers/user_controller.dart';
import 'package:epiece_shopping_app/routes/route_helper.dart';
import 'package:epiece_shopping_app/screens/piece/detail_piece.dart';
import 'package:epiece_shopping_app/screens/piece/more_piece.dart';
import 'package:epiece_shopping_app/uitls/scroll_behavior.dart';
import 'components/colors.dart';
import 'helper/get_dependecies.dart' as dep;
import 'package:get/get.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartsData();
      return  GetBuilder<ProductController>(builder:(_){
          return GetBuilder<PopularProduct>(builder: (_){
            return GetMaterialApp(
              scrollBehavior: AppScrollBehavior(),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                fontFamily: "Lato",
              ),

              initialRoute: RouteHelper.getSplashRoute(),
              getPages: RouteHelper.routes,
              defaultTransition: Transition.topLevel,
            );
          });
        });

  }
}
