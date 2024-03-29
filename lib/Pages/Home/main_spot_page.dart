import 'package:play_spots/Pages/Home/sports_group_button.dart';
import 'package:play_spots/Widgets/big_text.dart';
import 'package:play_spots/Widgets/small_text.dart';
import 'package:play_spots/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:play_spots/utils/colors.dart';

import 'spot_page_body.dart';

class MainSpotPage extends StatefulWidget {
  const MainSpotPage({Key? key}) : super(key: key);

  @override
  State<MainSpotPage> createState() => _MainSpotPageState();
}

class _MainSpotPageState extends State<MainSpotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height5 * 10,
                bottom: Dimensions.height5 * 4,
              ),
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/image/logo_name.png",
                    height: Dimensions.all1 * 30,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: Dimensions.all1 * 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BigText(
                              text: "Mumbai",
                              color: textColor,
                              size: Dimensions.all1 * 18,
                            ),
                            SmallText(
                              text: "Maharashtra, India",
                              color: black54,
                              size: Dimensions.all1 * 10,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/image/placeholder.png",
                        height: Dimensions.all1 * 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimensions.all1 * 10),
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.all1 * 15),
                  child: Container(color: white, child: SportsGroupButton()),
                )),
          ),
          Expanded(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SpotPageBody(),
          )),
        ],
      ),
    );
  }
}
