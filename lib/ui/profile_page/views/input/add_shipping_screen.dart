import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/util/context_extension.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/input/custom_dropdown_box.dart';
import 'package:salicta_mobile/util/widgets/input/custom_input_box.dart';

class AddShippingScreen extends StatelessWidget {
  AddShippingScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  void _addressOnChanged(String val) {
  }

  String? _addressValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter the address";
    } else {
      return null;
    }
  }

  void _pincodeOnChanged(String val) {
  }

  String? _pincodeValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter your pincode";
    } else if (!val!.isNum) {
      return "Please enter a valid pincode";
    } else if (val.length != 6) {
      return "Pincode must be 6 characters long";
    } else {
      return null;
    }
  }

  void _cityOnChanged(String val) {
  }

  String? _cityValidator(val) {
    return (val == null) ? "Please Select the City" : null;
  }

  void _districtOnChanged(String val) {
  }

  String? _districtValidator(val) {
    return (val == null) ? "Please Select the District" : null;
  }

  void _uploadAddress() {
    if (_formKey.currentState!.validate()) {
    }
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
          "ADD SHIPPING ADDRESS",
          style: kMerriweatherBold16,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInputBox(
                  headerText: "Address",
                  hintText: "Ex: 87 Church Street",
                  textInputType: TextInputType.streetAddress,
                  onChanged: _addressOnChanged,
                  validator: _addressValidator,
                ),
                CustomInputBox(
                  headerText: "Zipcode (Postal Code)",
                  hintText: "Ex: 600014",
                  maxLength: 6,
                  textInputAction: TextInputAction.done,
                  onChanged: _pincodeOnChanged,
                  validator: _pincodeValidator,
                ),

                CustomDropdownBox(
                  headerText: "District",
                  hintText: "Select District",
                  items: const [
                    DropdownMenuItem(
                      value: "Galle",
                      child: Text("Galle"),
                    ),
                    DropdownMenuItem(
                      value: "Matara",
                      child: Text("Matara"),
                    ),
                    DropdownMenuItem(
                      value: "Hambantota",
                      child: Text("Hambantota"),
                    ),
                    DropdownMenuItem(
                      value: "Colombo",
                      child: Text("Colombo"),
                    ),
                    DropdownMenuItem(
                      value: "Gampaha",
                      child: Text("Gampaha"),
                    ),
                    DropdownMenuItem(
                      value: "Kandy",
                      child: Text("Kandy"),
                    ),
                    DropdownMenuItem(
                      value: "Kalutara",
                      child: Text("Kalutara"),
                    ),

                  ],
                  onChanged: _districtOnChanged,
                  validator: _districtValidator,
                ),
                CustomDropdownBox(
                  headerText: "City",
                  hintText: "Select City",
                  items: const [
                    DropdownMenuItem(
                      value: "Chennai",
                      child: Text("Chennai"),
                    ),
                    DropdownMenuItem(
                      value: "Galle City",
                      child: Text("Galle City"),
                    ),
                  ],
                  onChanged: _cityOnChanged,
                  validator: _cityValidator,
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  height: context.dynamicHeight(0.07),
                  onTap: _uploadAddress,
                  text: "SAVE ADDRESS",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
