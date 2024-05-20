import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/input/custom_input_box.dart';

class AddPaymentScreen extends StatelessWidget {
  AddPaymentScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  void _addCard() {

  }

  void _nameOnChanged(String val) {

  }

  void _cardNumberOnChanged(String val) {

  }

  void _cvvOnChanged(String val) {
  }

  void _dateOnChanged(String val) {

  }

  String? _nameValidator(String? val) {
    return (val?.isNotEmpty ?? false) ? null : "Enter a name";
  }

  String? _cardNumberValidator(String? val) {
    return (val != null && val.length == 20)
        ? null
        : "Enter a Valid Credit Card Number";
  }

  String? _cvvValidator(String? val) {
    return (val != null && val.length == 3) ? null : "Enter CVV";
  }

  String? _dateValidator(String? val) {
    return "Enter a Valid Date";
  }

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
          "ADD PAYMENT METHOD",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Obx(
                //   () {
                //     return PaymentCardView(
                //       cardHolderName: (_controller.name.isEmpty)
                //           ? "XXXXXX"
                //           : _controller.name.value,
                //       expiryDateString: (_controller.dateString.isEmpty)
                //           ? "XX/XX"
                //           : _controller.dateString.value,
                //       lastFourDigits: (_controller.lastFourDigits.isEmpty)
                //           ? "XXXX"
                //           : _controller.lastFourDigits.value,
                //     );
                //   },
                // ),
                const SizedBox(height: 30),
                CustomInputBox(
                  headerText: "CardholderName",
                  hintText: "Ex: Aditya R",
                  textInputType: TextInputType.name,
                  onChanged: _nameOnChanged,
                  validator: _nameValidator,
                ),
                CustomInputBox(
                  headerText: "Card Number",
                  hintText: "Ex: XXXX XXXX XXXX 3456",
                  textInputType: TextInputType.number,
                  maxLength: 20,
                  inputFormatters: [CreditCardFormatter()],
                  onChanged: _cardNumberOnChanged,
                  validator: _cardNumberValidator,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomInputBox(
                        headerText: "CVV",
                        hintText: "Ex: 123",
                        maxLength: 3,
                        obscureText: true,
                        onChanged: _cvvOnChanged,
                        validator: _cvvValidator,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: CustomInputBox(
                        headerText: "Expiration Date",
                        hintText: "Ex: 04/22",
                        maxLength: 5,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [DateFormatter()],
                        onChanged: _dateOnChanged,
                        validator: _dateValidator,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  onTap: _addCard,
                  text: "ADD NEW CARD",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
