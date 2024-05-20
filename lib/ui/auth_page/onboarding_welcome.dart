import 'package:flutter/material.dart';
import 'package:salicta_mobile/ui/auth_page/login_page/login_provider.dart';
import 'package:salicta_mobile/theme/constants.dart';

class OnBoardingWelcomeScreen extends StatelessWidget {
  const OnBoardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onBoarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MAKE YOUR',
                  style: kGelasio18.copyWith(
                    color: kGraniteGrey,
                    fontSize: 24,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'HOME BEAUTIFUL',
                  style: kGelasio18.copyWith(
                    color: primaryGreen,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 25),
                  child: Text(
                    "The best simple place where you discover most wonderful furniture's and make your home beautiful",
                    style: kNunitoSans18.copyWith(
                      color: kGrey,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),
            Container(
              height: 55,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  LoginProvider(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shadowColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: kGelasio18.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
