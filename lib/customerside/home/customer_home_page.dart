import 'package:cleaning/customewidget.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/whatsapp.dart';

import '../../customersideController.dart';
import '../../keys.dart';
import '../../utils/color.dart';
import '../../utils/common_widgets.dart';
import '../../utils/controller.dart';
import '../customer_tab_screen.dart';
import '../view_all_proposals.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final Globlecontroller globlecontroller = Get.find();
  CustomerSideController customerSideController = Get.find();
  WhatsApp whatsapp = WhatsApp();

  @override
  void initState() {
    // TODO: implement initState
    getMyPostedJobs();
    super.initState();
  }

  getMyPostedJobs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(Keys().customerID)!);
    print(
      prefs.getString(Keys().sessionID)!,
    );

    customerSideController.getLatestProposals(prefs.getString(Keys().customerID)!, prefs.getString(Keys().sessionID)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: Image.asset(ImageAssets.bottomImg2),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: appBarBorderColor,
            height: 2.0,
          ),
        ),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        title: Image.asset(
          ImageAssets.sparkleImg,
          scale: 2,
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'New Proposals'.tr,
                        style: TextStyle(
                          color: black2,
                          fontSize: 22,
                          fontFamily: CustomStrings.dnmed,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                        backgroundColor: const Color(0x33B0D6FF),
                        radius: 12,
                        child: Text(
                          customerSideController.proposalList.length.toString(),
                          style: const TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 12,
                            fontFamily: CustomStrings.dbold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>AllNewProposals());
                    },
                    child: Row(
                      children: [
                        Text(
                          'View all'.tr,
                          style: TextStyle(
                            color: blueColor,
                            fontSize: 14,
                            fontFamily: CustomStrings.dnmed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          ImageAssets.arrow1,
                          scale: 2,
                          color: blueColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              customerSideController.loading.value
                  ? const LoadingWidget()
                  : customerSideController.proposalList.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          // width: 267,
                          height: 332,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: customerSideController.proposalList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 267,
                                  height: 332,
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                                  decoration: ShapeDecoration(
                                    color: white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: Color(0xFFD3E1E4)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          //
                                          const CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Color(0x33B0D6FF),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              customerSideController.proposalList[index].providerDetails.Name,
                                              style: const TextStyle(
                                                color: Color(0xFF2F4246),
                                                fontSize: 14,
                                                fontFamily: CustomStrings.dbold,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Expanded(
                                        child: Text(
                                          customerSideController.proposalList[index].providerDetails.description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xFF668F98),
                                            fontSize: 16,
                                            fontFamily: CustomStrings.dnmed,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bid Amount  '.tr,
                                            style: const TextStyle(
                                              color: Color(0xFF161616),
                                              fontSize: 12,
                                              // fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                              fontFamily: CustomStrings.dnmed,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              customerSideController.proposalList[index].Amount.toString(),
                                              style: const TextStyle(
                                                color: Color(0xFF007AFF),
                                                fontSize: 16,
                                                fontFamily: CustomStrings.dnmed,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      GestureDetector(
                                        onTap: () {
                                          sendWhatsAppMessage(customerSideController.proposalList[index].providerDetails.phone);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 48,
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(width: 1, color: Color(0xFF007AFF)),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                ImageAssets.whatsapp,
                                                scale: 2,
                                              ),
                                              Text(
                                                'Chat now'.tr,
                                                style: TextStyle(
                                                  color: blueColor,
                                                  fontSize: 14,
                                                  fontFamily: CustomStrings.dbold,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
              const SizedBox(height: 28),
              Text(
                'Looking for another Proposal ?'.tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: CustomStrings.dnmed,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                  width: 235,
                  child: appButton2(
                      onPressed: () {
                        // Get.delete<CustomerSideController>();
                        Get.offAll(() => const CustomerTabScreen(
                              selectIndex: 2,
                            ));
                      },
                      title: "Create a new proposal".tr,
                      borderColor: blueColor,
                      textColor: blueColor,
                      bgColor: white,
                      img: ImageAssets.add2)),
            ],
          ),
        );
      }),
    );
  }
}
