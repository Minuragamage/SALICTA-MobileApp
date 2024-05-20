import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/context_extension.dart';
import 'package:salicta_mobile/util/widgets/buttons/custom_elevated_button.dart';
import 'package:salicta_mobile/util/widgets/input/custom_input_box.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  const EditPersonalInformationScreen({super.key});

  @override
  State<EditPersonalInformationScreen> createState() =>
      _EditPersonalInformationScreenState();
}

class _EditPersonalInformationScreenState
    extends State<EditPersonalInformationScreen> {
  String name = "";
  final _formKey = GlobalKey<FormState>();

  void _nameOnChanged(String val) {
    name = val;
  }

  String? _nameValidator(String? val) {
    if (val?.isEmpty ?? true) {
      return "Please enter the name";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rootCubit = BlocProvider.of<RootCubit>(context);

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
          "EDIT PERSONAL INFORMATION",
          style: kMerriweatherBold16,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<RootCubit, RootState>(
                  buildWhen: (previous, current) =>
                      previous.currentUser != current.currentUser,
                  builder: (context, snapshot) {
                    return CustomInputBox(
                      headerText: "Name",
                      hintText: "Ex: Aditya",
                      initialValue: snapshot.currentUser!.name,
                      textInputType: TextInputType.name,
                      onChanged: _nameOnChanged,
                      validator: _nameValidator,
                    );
                  }),
              const Spacer(),
              CustomElevatedButton(
                height: context.dynamicHeight(0.06),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    rootCubit.updateUserName(name);
                  }
                },
                text: "SAVE DETAILS",
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: context.dynamicHeight(0.06),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kOffBlack,
                    side: const BorderSide(color: kFireOpal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: kNunitoSansSemiBold18.copyWith(
                      color: kFireOpal,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
