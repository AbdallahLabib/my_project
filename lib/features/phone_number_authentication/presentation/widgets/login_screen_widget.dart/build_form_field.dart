import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/core/constants/colors.dart';
import 'package:flutter_maps/features/phone_number_authentication/presentation/bloc/phone_auth_bloc.dart';

class BuildFormField extends StatefulWidget {
  const BuildFormField({super.key});

  @override
  State<BuildFormField> createState() => _BuildFormFieldState();
}

class _BuildFormFieldState extends State<BuildFormField> {
  late String phoneNumber;
  final TextEditingController phoneNumberController = TextEditingController();

//  @override
//   void initState(){
//     phoneNumberController.text =phoneNumber ;
//     super.initState();
//   }

  /* void updatePhoneNumber(value){
    setState(() {
      phoneNumber = value;
    });
  } */
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
                border: Border.all(color: MyColors.lightBlue),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: Text(
              '${_generateCountryFlag()}+20',
              style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(color: MyColors.blue),
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: TextFormField(
              autofocus: true,
              style: const TextStyle(fontSize: 18, letterSpacing: 2),
              decoration: const InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please enter your phone number';
                } else if (value.length < 11) {
                  return 'too short for a phone number';
                }
                return null;
              },
              controller: phoneNumberController,
              onChanged: (value) =>
                  BlocProvider.of<PhoneAuthBloc>(context).phoneNumber = value,
              /* onSaved: (value) {
               updatePhoneNumber(value);
              }, */
            ),
          ),
        ),
      ],
    );
  }

  String _generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }
}
