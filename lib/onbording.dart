import 'package:cleaning/signup/login_screen.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardingPage extends StatefulWidget {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  State<BoardingPage> createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  @override
  final Globlecontroller globlecontroller = Get.find();

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _slides = [
      Slide("assets/images/pexels-photo-6238368 1.png", "p1".tr, "p1s".tr
          // CustomStrings.p1[globlecontroller.language.value],
          // CustomStrings.p1s[globlecontroller.language.value],
          ),
      Slide("assets/images/pexels-photo-5708232 1.png", "p2".tr, "p2s".tr
          // CustomStrings.p2[globlecontroller.language.value],
          // CustomStrings.p2s[globlecontroller.language.value],
          ),
      Slide("assets/images/pexels-photo-4464822 1.png", "p3".tr, "p3s".tr
          // CustomStrings.p3[globlecontroller.language.value],
          // CustomStrings.p3s[globlecontroller.language.value],
          ),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: Get.height / 1.3,
                width: double.infinity,
                child: ClipRRect(
                  child: Image.asset(
                    slide.image,
                    fit: BoxFit.fill,
                    scale: 4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height / 10),
              child: Container(
                height: Get.height / 1.3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [lightblue, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                width: double.infinity,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height / 3.2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width / 10, right: Get.height / 10, top: Get.height / 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slide.heading,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: CustomStrings.font),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Text(
                          slide.subtext,
                          style: TextStyle(color: greytext, fontSize: 14, fontFamily: CustomStrings.dnreg),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildPageIndicator() {
    Row row = const Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        // ignore: curly_braces_in_flow_control_structures
        row.children.add(const SizedBox(
          width: 10,
        ));
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 12 : 8,
      height: index == _currentPage ? 12 : 8,
      decoration: BoxDecoration(shape: BoxShape.circle, color: index == _currentPage ? Colors.white : Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return PageView(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: _handlingOnPageChanged,
                  children: _buildSlides(),
                );
              }),
          _currentPage == 2
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: CircleAvatar(
                          backgroundColor: primmarycolor,
                          radius: 25,
                          child: Center(
                            child: Icon(
                              Icons.navigate_next,
                              color: white,
                            ),
                          ),
                        )),
                  ))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        _pageController.nextPage(duration: const Duration(microseconds: 300), curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: primmarycolor,
                        child: Center(
                          child: Icon(
                            Icons.navigate_next,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}

class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}
