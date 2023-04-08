// ignore_for_file: unused_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:gg/cubit/cache_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/constants.dart';
import '../../model/on_boarding.dart';
import '../../widgets/on_boarding.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late LiquidController liquidController;
  int currentPage = 0;
  bool isLastPage = false;
  void onPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      OnBoardingPage(
        Model: OnBoarding(
          image: onBoardingIamge1,
          title: title1,
          subtitle: subtitle1,
          counterText: counter1,
          bgColor: Color1,
        ),
      ),
      OnBoardingPage(
        Model: OnBoarding(
          image: onBoardingIamge2,
          title: title2,
          subtitle: subtitle2,
          counterText: counter2,
          bgColor: Color2,
        ),
      ),
      OnBoardingPage(
        Model: OnBoarding(
          image: onBoardingIamge3,
          title: title3,
          subtitle: subtitle3,
          counterText: counter3,
          bgColor: Color3,
        ),
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            liquidController: liquidController,
            onPageChangeCallback: onPageChangeCallback,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 30.0,
            child: currentPage == 2
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          CacheHelper.saveData(key: 'onBoarding', value: true)
                              .then((value) {
                            if (value) {
                              Navigator.pushNamed(context, '/Login');
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 90, 69, 255),
                            minimumSize: const Size(150, 60),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(0),
                              ),
                            )),
                        child: Text(
                          Login,
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              height: 1.26,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Register');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          minimumSize: const Size(150, 60),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                        child: Text(
                          SignUp,
                          style: GoogleFonts.outfit(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              height: 1.26,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 253, 253),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : OutlinedButton(
                    onPressed: () {
                      int nextPage = liquidController.currentPage + 1;
                      liquidController.animateToPage(page: nextPage);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black26),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xff272727),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: TextButton(
              onPressed: () => liquidController.jumpToPage(page: 2),
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: liquidController.currentPage,
              count: 3,
              effect: const WormEffect(
                activeDotColor: Color(0xff272727),
                dotHeight: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
