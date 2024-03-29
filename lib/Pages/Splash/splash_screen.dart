import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:play_spots/Pages/Profile/profile_page.dart';
import 'package:play_spots/Routes/route_helper.dart';
import 'package:play_spots/utils/dimensions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../Controllers/popular_spot_controller.dart';
import '../../Controllers/recommended_spot_controller.dart';
import '../Login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  final auth = FirebaseAuth.instance.currentUser;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    if (auth != null) {
      setState(() {
        initialProfile = false;
        userName.text =
            FirebaseAuth.instance.currentUser!.displayName.toString();
        // phoneNumber.text =
        //     FirebaseAuth.instance.currentUser!.phoneNumber.toString();
        emailController.text =
            FirebaseAuth.instance.currentUser!.email.toString();
      });
    }
    Timer(
        const Duration(seconds: 1),
        () => auth == null
            ? Get.offNamed(RouteHelper.getAuthentication())
            : Get.offNamed(RouteHelper.getInitial())
        // (() {
        //     return Get.offNamed(RouteHelper.getAuthentication());
        //   })
        // : (() {
        //     setState(() {
        //       initialProfile = false;
        //       userName.text =
        //           FirebaseAuth.instance.currentUser!.displayName.toString();
        //       phoneNumber.text =
        //           FirebaseAuth.instance.currentUser!.phoneNumber.toString();
        //       emailController.text =
        //           FirebaseAuth.instance.currentUser!.email.toString();
        //     });
        //     return Get.offNamed(RouteHelper.getInitial());
        //   })
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Dimensions.height20,
          ),
          Center(
            child: Image.asset(
              "assets/image/logo.png",
              width: Dimensions.splashImg,
            ),
          ),
          // ScaleTransition(
          //   scale: animation,
          //   child: Center(
          //     child: Image.asset(
          //       "assets/image/logo1.png",
          //       width: Dimensions.splashImg,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: Dimensions.height20,
          // ),
          // // FadeTransition(
          // //   opacity: animation,
          // //   child: Center(
          // //     child: Image.asset(
          // //       "assets/image/logo2.png",
          // //       width: Dimensions.splashImgText,
          // //     ),
          // //   ),
          // // ),
          // Center(
          //   child: Image.asset(
          //     "assets/image/logo2.png",
          //     width: Dimensions.splashImgText,
          //   ),
          // ),
        ],
      ),
    );
  }
}
