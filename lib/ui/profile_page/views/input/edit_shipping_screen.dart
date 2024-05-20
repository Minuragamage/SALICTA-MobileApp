import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/db/model/address.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/input/custom_dropdown_box.dart';
import 'package:salicta_mobile/util/widgets/input/custom_input_box.dart';

class EditShippingScreen extends StatelessWidget {
  final Address initialAddress;
  final int index;
  final _formKey = GlobalKey<FormState>();

  EditShippingScreen(
      {super.key, required this.initialAddress, required this.index}) {
  }

  void _nameOnChanged(String val) {
  }

  String? _nameValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter your name";
    } else {
      return null;
    }
  }

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

  void _countryOnChanged(String val) {
  }

  String? _countryValidator(val) {
    return (val == null) ? "Please Select the Country" : null;
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

  void _editAddress() {
    if (_formKey.currentState!.validate()) {
    }
  }

  void _deleteAddress() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kOffBlack,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "EDIT SHIPPING ADDRESS",
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
                  initialValue: initialAddress.address,
                  onChanged: _addressOnChanged,
                  validator: _addressValidator,
                ),
                CustomDropdownBox(
                  headerText: "City",
                  hintText: "Select City",
                  initialValue: initialAddress.city,
                  items: const [
                    DropdownMenuItem(
                      value: "Chennai",
                      child: Text("Chennai"),
                    )
                  ],
                  onChanged: _cityOnChanged,
                  validator: _cityValidator,
                ),
                CustomDropdownBox(
                  headerText: "District",
                  hintText: "Select District",
                  initialValue: initialAddress.district,
                  items: const [
                    DropdownMenuItem(
                      value: "Mylapore",
                      child: Text("Mylapore"),
                    )
                  ],
                  onChanged: _districtOnChanged,
                  validator: _districtValidator,
                ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  onTap: _editAddress,
                  text: "EDIT ADDRESS",
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _deleteAddress,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: kOffBlack,
                      side: const BorderSide(color: kFireOpal),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "DELETE",
                      style: kNunitoSansSemiBold18.copyWith(
                        color: kFireOpal,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
