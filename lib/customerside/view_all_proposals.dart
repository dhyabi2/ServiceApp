import 'package:cleaning/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customersideController.dart';
import '../keys.dart';
import '../utils/color.dart';
import '../utils/image_asset.dart';
import '../utils/string.dart';

class AllNewProposals extends StatefulWidget {
  const AllNewProposals({Key? key}) : super(key: key);

  @override
  State<AllNewProposals> createState() => _AllNewProposalsState();
}

class _AllNewProposalsState extends State<AllNewProposals> {
  CustomerSideController customerSideController = Get.find();

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
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              ImageAssets.backIcon,
              scale: 2,
            )),
        title: Text(
          'New Proposals'.tr,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: appBarBorderColor,
            height: 2.0,
          ),
        ),
      ),
      body: Obx(() {
        return customerSideController.loading.value
            ? const LoadingWidget()
            : customerSideController.proposalList.isEmpty
                ? const SizedBox()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: SizedBox(
                            width: 267,
                            // height: 332,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: customerSideController.proposalList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 267,
                                    height: 332,
                                    margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
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
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
