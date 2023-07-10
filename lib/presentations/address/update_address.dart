import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionstore/model/address_model.dart';
import 'package:fashionstore/widgets/appbar.dart';
import 'package:fashionstore/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../widgets/main_heading_widget.dart';
import 'widgets/textfield_widget.dart';

class EditAdressScreen extends StatefulWidget {
  const EditAdressScreen({super.key, required this.data});

  final Address data;

  @override
  State<EditAdressScreen> createState() => _EditAdressScreenState();
}

class _EditAdressScreenState extends State<EditAdressScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.data.name!;
    addressController.text = widget.data.permanentAddress!;
    pincodeController.text = widget.data.pinCode.toString();
    stateController.text = widget.data.state!;
    cityController.text = widget.data.city!;
    phoneController.text = widget.data.phone.toString();
    super.initState();
  }

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
                MainHeading(
                  text: 'Edit Address',
                ),
                SizedBox(
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
                khieght20,
                SizedBox(
                  width: size.width * 0.95,
                  child: TextButton(
                    onPressed: () async {
                      await updateAddressToFirestore(context);
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
                          Icons.update_rounded,
                          color: Colors.white,
                        ),
                        kwidth10,
                        Text(
                          'Update',
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

  Future<void> updateAddressToFirestore(BuildContext context) async {
    final cart = FirebaseFirestore.instance.collection('address');
    String email = FirebaseAuth.instance.currentUser!.email!;

    final reference = cart.doc(widget.data.id);
    try {
      await reference.update({
        'name': nameController.text,
        'address': addressController.text,
        'pincode': pincodeController.text,
        'phone': phoneController.text,
        'city': cityController.text,
        'state': stateController.text,
        'email': email,
      }).then((value) {
        alertSnackbar(context, "Address Updated");
        Navigator.pop(context);
      });
      log('Address Updated to Firestore');
    } catch (e) {
      log('Error while Updating address to Firestore: $e');
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
