import 'package:cleaning/customewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../customerside/customer_tab_screen.dart';
import '../utils/color.dart';
import '../utils/image_asset.dart';
import '../utils/string.dart';

class SecondWelcomeScreen extends StatefulWidget {
  const SecondWelcomeScreen({super.key});

  @override
  State<SecondWelcomeScreen> createState() => _SecondWelcomeScreenState();
}

class _SecondWelcomeScreenState extends State<SecondWelcomeScreen> {
  late PageController _controller;

  List<Map<String, String>> list = [
    {"img": ImageAssets.sittingIcon, "title": "Home Cleaning Made Easy", "subTitle": "desc1"},
    {"img": ImageAssets.taskImg, "title": "Choose Time and Date", "subTitle": "desc2"},
    {"img": ImageAssets.mapImg, "title": "Convenient Location", "subTitle": "desc3"}
  ];
  int currentPage = 0;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
      keepPage: true,
    )..addListener(_listener);
    super.initState();
  }

  _listener() {
    currentPage = _controller.page!.toInt();
    setState(() {});
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      print('swiped to right');
    } else {
      print('swiped to left');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            ImageAssets.sparkleImg,
            scale: 2,
          )),
      bottomNavigationBar: Image.asset(
        ImageAssets.bottomImg,
        scale: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => const SecondWelcomeScreen());
              },
              child: Text(
                "Skip and access my account".tr,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: blueColor, fontFamily: CustomStrings.dbold),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: getScreenHeight(context) * 0.47,
              child: PageView.builder(
                  controller: _controller,
                  itemCount: list.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image.asset(
                          list[index]["img"] ?? "",
                          scale: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SmoothPageIndicator(
                            controller: _controller,
                            count: list.length,
                            axisDirection: Axis.horizontal,
                            effect: ExpandingDotsEffect(activeDotColor: blueColor, dotColor: greyText2, dotHeight: 5, radius: 10, dotWidth: 10)),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            list[index]["title"].toString().tr ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: greytext, fontFamily: CustomStrings.dnmed),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            list[index]["subTitle"].toString().tr ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: greytext, fontFamily: CustomStrings.dnmed),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            currentPage == 0
                ? Padding(
                    padding: EdgeInsets.only(left: Get.width / 1.7),
                    child: appButton(
                        onTap: () async {
                          currentPage = 1;
                          await _controller.animateToPage(currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          setState(() {});
                        },
                        title: "Start My Tour".tr,
                        clr: blueColor))
                : _controller.page == 1
                    ? Padding(
                        padding: EdgeInsets.only(left: getScreenWidth(context) * 0.3),
                        child: Row(
                          children: [
                            Expanded(
                                child: appButton2(
                                    onPressed: () async {
                                      currentPage = 0;
                                      await _controller.animateToPage(currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                      setState(() {});
                                    },
                                    title: "Previous".tr,
                                    textColor: blueColor,
                                    borderColor: blueColor,
                                    img: ImageAssets.arrow2)),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () async {
                                currentPage = 2;
                                await _controller.animateToPage(currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                setState(() {});
                              },
                              child: Container(
                                height: Get.height / 16,
                                decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Next".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: CustomStrings.dnmed,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Image.asset(
                                        ImageAssets.arrow1,
                                        scale: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(left: getScreenWidth(context) * 0.3),
                        child: Row(
                          children: [
                            Expanded(
                                child: appButton2(
                                    onPressed: () async {
                                      await _controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                      setState(() {});
                                    },
                                    title: "Previous".tr,
                                    textColor: blueColor,
                                    borderColor: blueColor,
                                    img: ImageAssets.arrow2)),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () async {
                                Get.to(() => const CustomerTabScreen(
                                  selectIndex: 0,
                                ));
                              },
                              child: Container(
                                height: Get.height / 16,
                                decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Finish".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: CustomStrings.dnmed,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Image.asset(
                                        ImageAssets.arrow1,
                                        scale: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
          ],
        ),
      ),
    );
  }
}

getScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}

getScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}
