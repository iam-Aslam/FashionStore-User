import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/main_heading_widget.dart';
import 'package:fashionstore/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/textfield_widget.dart';

final _formKey = GlobalKey<FormState>();

class AddNewAddresScreen extends StatelessWidget {
  AddNewAddresScreen({super.key, this.fromCheckOut = false});

  final bool fromCheckOut;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Appbar(goBack: true),
                Row(
                  children: [
                    const MainHeading(
                      text: 'Add Address',
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          CupertinoIcons.pencil,
                          size: 30,
                          color: Colors.black,
                        ))
                  ],
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: size.height * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFieldWidget(
                          size: size,
                          fieldName: "Name",
                          colorValue: Colors.grey.withOpacity(0.2),
                          textController: nameController,
                          validator: _nameValidator,
                        ),
                        TextFieldWidget(
                          size: size,
                          fieldName: "Pin Code",
                          colorValue: Colors.grey.withOpacity(0.2),
                          numPad: true,
                          textController: pincodeController,
                          validator: _pincodeValidator,
                        ),
                        TextFieldWidget(
                          size: size,
                          fieldName: "Address",
                          colorValue: Colors.grey.withOpacity(0.2),
                          textController: addressController,
                          validator: _addressValidator,
                        ),
                        TextFieldWidget(
                          size: size,
                          fieldName: "Phone",
                          colorValue: Colors.grey.withOpacity(0.2),
                          numPad: true,
                          textController: phoneController,
                          validator: _phoneValidator,
                        ),
                        TextFieldWidget(
                          size: size,
                          fieldName: "City",
                          colorValue: Colors.grey.withOpacity(0.2),
                          textController: cityController,
                          validator: _cityValidator,
                        ),
                        TextFieldWidget(
                          size: size,
                          fieldName: "State",
                          colorValue: Colors.grey.withOpacity(0.2),
                          textController: stateController,
                          validator: _stateValidator,
                        ),
                      ],
                    ),
                  ),
                ),
                khieght20,
                SizedBox(
                  width: size.width * 0.95,
                  child: TextButton(
                    onPressed: () async {
                      await addAddressToFirestore(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(vertical: 20)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.home,
                          color: Colors.white,
                        ),
                        kwidth10,
                        Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
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

  Future<void> addAddressToFirestore(BuildContext context) async {
    final cart = FirebaseFirestore.instance.collection('address');

    final reference = cart.doc();
    try {
      await reference.set({
        'name': nameController.text,
        'address': addressController.text,
        'pincode': pincodeController.text,
        'phone': phoneController.text,
        'city': cityController.text,
        'state': stateController.text,
        'email': email,
        'id': reference.id,
      }).then((value) {
        alertSnackbar(context, "Address Added");
        Navigator.pop(context);
      });
      log('Address added to Firestore');
    } catch (e) {
      log('Error adding address to Firestore: $e');
    }
  }

  String? _nameValidator(String? value) {
    if (nameController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _addressValidator(String? value) {
    if (addressController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _pincodeValidator(String? value) {
    if (pincodeController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (phoneController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _stateValidator(String? value) {
    if (stateController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }

  String? _cityValidator(String? value) {
    if (cityController.text.trim().isEmpty) {
      return 'This field cant be emtpy';
    }
    return null;
  }
}
