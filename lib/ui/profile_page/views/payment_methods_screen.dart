import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/profile_page/views/input/add_payment_screen.dart';
import 'package:salicta_mobile/util/widgets/cards/payment_card_view.dart';

class PaymentMethodsScreen extends StatelessWidget {
  PaymentMethodsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kOffBlack,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "PAYMENT METHOD",
          style: kMerriweatherBold16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPaymentScreen(),
            ),
          );
        },
        elevation: 8,
        backgroundColor: Colors.white,
        foregroundColor: kOffBlack,
        child: const Icon(
          Icons.add,
          size: 34,
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        itemBuilder: (context, index) {
          return Column(
            children: [
              PaymentCardView(
                cardHolderName: 'User',
                lastFourDigits: '1246',
                expiryDateString:
                "2025-10-22",
                isMasterCard: index % 2 == 0,
                isSelected:true,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    child: Checkbox(
                      value:false,
                      onChanged: (isSelected) {},
                      activeColor: kOffBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      splashRadius: 20,
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  Text(
                    "Use as default payment method",
                    style: kNunitoSans14.copyWith(
                      color: kRaisinBlack,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
