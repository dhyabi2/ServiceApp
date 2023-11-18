import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final Globlecontroller globlecontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightback,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: darktext),
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          "Customers Feedback",
          style: TextStyle(fontSize: 18, fontFamily: CustomStrings.font, color: darktext),
        ),
      ),
      body: notificationlist(),
    );
  }

  Widget notificationlist() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: Get.height / 50, left: Get.width / 20, right: Get.width / 20),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: Get.height / 6,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: white),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/pro.png",
                          scale: 4,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Compoy Name",
                              style: TextStyle(color: knokgrey, fontSize: 16, fontFamily: CustomStrings.dbold),
                            ),
                            SizedBox(
                              width: Get.width / 5,
                            ),
                            Image.asset(
                              "assets/images/rate.png",
                              scale: 4,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: Get.width / 1.5,
                          child: Text(
                            "we are offer all type of service and promise to be exellent service you will get.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: greytext,
                              fontSize: 14,
                              fontFamily: CustomStrings.dnmed,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              "19-05-2023",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: primmarycolor,
                                fontSize: 14,
                                fontFamily: CustomStrings.dnmed,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
