import 'package:play_spots/Controllers/popular_spot_controller.dart';
import 'package:play_spots/Controllers/recommended_spot_controller.dart';
import 'package:play_spots/Routes/route_helper.dart';
import 'package:play_spots/Widgets/big_text.dart';
import 'package:play_spots/Widgets/expandable_text_widget.dart';
import 'package:play_spots/utils/colors.dart';
import 'package:play_spots/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../Controllers/cart_controller.dart';
import '../../Widgets/app_icon.dart';
import '../../Widgets/icon_text_widget.dart';
import '../../Widgets/small_text.dart';
import '../Cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: white,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: Dimensions.height20 * 4,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartPage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.clear_rounded)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                          ),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  top: Dimensions.all1 * 4,
                                  right: Dimensions.all1 * 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: Dimensions.width1 / 17.6,
                                    height: Dimensions.height1 / 17.6,
                                    child: Center(
                                      child: BigText(
                                        text:
                                            Get.find<PopularProductController>()
                                                .totalItems
                                                .toString(),
                                        size: Dimensions.font12 / 1.5,
                                        color: white,
                                      ),
                                    ),
                                  ))
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height15),
                child: Container(
                  child: Center(
                      child: BigText(
                    text: product.name!,
                    size: Dimensions.font26,
                  )),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: Dimensions.height5,
                    bottom: Dimensions.height10,
                  ),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                ),
              ),
              pinned: true,
              backgroundColor: imageShadeColor,
              expandedHeight: Dimensions.height30 * 10,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height45,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                                child: Wrap(
                              children: List.generate(
                                5,
                                ((index) {
                                  return Icon(
                                    Icons.star,
                                    color: Color.fromARGB(255, 218, 218, 218),
                                  );
                                }),
                              ),
                            )),
                            Wrap(
                              children: List.generate(
                                product.stars!,
                                ((index) {
                                  return Icon(
                                    Icons.star,
                                    color: mainColor,
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        SmallText(text: "1287 comments"),
                        SmallText(text: ""),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTextWidget(
                            icon: Icons.currency_rupee_rounded,
                            text: product.price!.toString(),
                            size: Dimensions.font16,
                            iconColor: paraColor),
                        IconTextWidget(
                            icon: Icons.restaurant,
                            text: 'Shreeji',
                            iconColor: iconColor1),
                        Container(
                          height: Dimensions.iconSize24,
                          width: Dimensions.iconSize24,
                          decoration: BoxDecoration(
                            color: white38,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(product.vegNonVeg == "veg"
                                    ? "assets/image/veg.png"
                                    : "assets/image/non_veg.png")),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    ExpandableTextWidget(
                      text: product.description!,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: ((controller) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  Dimensions.width25 * 2,
                  Dimensions.height10,
                  Dimensions.width25 * 2,
                  Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        icon: Icons.remove_rounded,
                        iconColor: white,
                        backgroundColor: mainColor,
                      ),
                    ),
                    BigText(
                      text: "\₹ ${product.price!} X ${controller.inCartItems}",
                      color: mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        icon: Icons.add_rounded,
                        iconColor: white,
                        backgroundColor: mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimensions.bottomNavBarHeight,
                padding: EdgeInsets.fromLTRB(
                  Dimensions.all1 * 20,
                  Dimensions.all1 * 30,
                  Dimensions.all1 * 20,
                  Dimensions.all1 * 30,
                ),
                decoration: BoxDecoration(
                  color: buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.width20,
                        Dimensions.height20,
                        Dimensions.width20,
                        Dimensions.height20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius20,
                        ),
                        color: transparent,
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        color: transparent,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.width20,
                          Dimensions.height20,
                          Dimensions.width20,
                          Dimensions.height20,
                        ),
                        child: BigText(
                          text:
                              "\₹ ${product.price! * controller.inCartItems} | Add to cart",
                          color: white,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          }),
        ));
  }
}
