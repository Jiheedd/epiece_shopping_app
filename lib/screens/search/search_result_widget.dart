
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epiece_shopping_app/screens/search/widget/item_view.dart';

import '../../components/colors.dart';
import '../../controllers/search_product_controller.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../uitls/app_constants.dart';
import '../../uitls/app_dimensions.dart';
import '../../uitls/styles.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/text_widget.dart';
class SearchResultWidget extends StatefulWidget {
  final String searchText;
  SearchResultWidget({required this.searchText});

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

   // _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        GetBuilder<SearchProductController>(builder: (searchController) {
          bool _isNull = true;
          int _length = 0;

          _isNull = searchController.searchProductList == null;
          if(!_isNull) {
            _length = searchController.searchProductList!.length;
          }

          return _isNull ? SizedBox() : Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Row(children: [
              Text(
                _length.toString(),
                style: robotoBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                'results found',
                style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
          )));
        }),

        /* Center(child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        color: Theme.of(context).cardColor,
        child: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).disabledColor,
          unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
          labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
          tabs: [
            Tab(text: 'piece'),

          ],
        ),
      )),*/

        Expanded(child: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              //Get.find<SearchProductController>().setRestaurant(_tabController.index == 1);
              Get.find<SearchProductController>().searchData(widget.searchText);
            }
            return false;
          },
          child: Container(
            height: 500,
            child: GetBuilder<SearchProductController>(builder: (searchController) {
              return SingleChildScrollView(
                child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding:  EdgeInsets.only(top: Dimensions.padding10),
                  itemCount: searchController.searchProductList?.length,
                  itemBuilder: (context, index) {

                    return GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getPopularPieceRoute(index, "popular", RouteHelper.initial));
                        },
                        child:  Container(
                          margin:  EdgeInsets.only(left: Dimensions.appMargin, right: Dimensions.appMargin, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: Dimensions.listViewImg,
                                height: Dimensions.listViewImg,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.padding20),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            searchController.searchProductList![index].img

                                        )
                                    )
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: Dimensions.isWeb?EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL):EdgeInsets.all(0),
                                  height: Dimensions.listViewCon,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(Dimensions.padding20),
                                          bottomRight: Radius.circular(Dimensions.padding20)
                                      )
                                  ),
                                  child:Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.padding10, right: Dimensions.padding10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BigText(text: searchController.searchProductList![index].title,/* element.value,*/
                                            color: Colors.black87),
                                        SizedBox(height: Dimensions.padding10,),
                                        TextWidget(text: "With chinese characteristics", color: AppColors.textColor),
                                        SizedBox(height: Dimensions.padding10,),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconAndTextWidget(text: "Normal", color: AppColors.textColor, icon: Icons.circle, iconColor: AppColors.iconColor1,),

                                            IconAndTextWidget(text: "17km",color: AppColors.textColor, icon: Icons.location_on, iconColor: AppColors.mainColor,),

                                            IconAndTextWidget(text: "32min",color:AppColors.textColor, icon: Icons.access_time_rounded, iconColor: AppColors.iconColor2,)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              )
                            ],
                          ),
                        )
                    );
                  },
                ))),
              );
            }),
          ),
        )),

      ]),
    );
  }
}
