import 'package:kurir/Module/IntroductionPage/viewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';


class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();

    final controller = Get.find<IntroductionController>();

    Widget _buildFullscreenImage() {
      return Image.asset(
        'assets/images/ride.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      );
    }

    Widget _buildImage(String assetName, [double width = 350]) {
      return Image.asset('assets/images/$assetName', width: width);
    }

    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.transparent,
      // freeze: true,
      // allowImplicitScrolling: true,
      // autoScrollDuration: 3000,

      // infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            // child: _buildImage('flutter.png', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: Container(
            color: Colors.white,
          )),
      pages: [
        PageViewModel(
          title: "Selamat Datang",
          body: "kurir siap mengantar anda sampai tujuan",
          image: _buildImage('ride.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Promo Melimpah",
          body: "NIkmati promo melimpah dari kurir",
          image: _buildImage('ride.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Aman dan terpercaya",
          bodyWidget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Aman dan Nyaman", style: bodyStyle),
              // Text("keamanan dan kenyamanan anda", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('ride.jpg'),
          reverse: true,
        ),
      ],
      onDone: () => controller.handleIntroduction(),
      onSkip: () =>
          controller.handleIntroduction(), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
