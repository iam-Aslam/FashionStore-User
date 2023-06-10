import 'package:fashionstore/presentations/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fashionstore/presentations/onboarding_screens/widgets/pageindicator_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboard_core.dart';
import 'widgets/onboard_content.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: demoData[index].image,
                    title2: demoData[index].title2,
                    title1: demoData[index].title1,
                    description1: demoData[index].description1,
                    description2: demoData[index].description2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageIndicator(
                          currentValue: pageIndex,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogIn(),
                                  ));
                            },
                            child: Text('Skip',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    letterSpacing: .5,
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )))
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        pageIndex == 2
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogIn(),
                                ))
                            : _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right_sharp,
                        size: 50,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    _pageController.dispose();
    super.dispose();
  }
}
