// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fashionstore/model/address_model.dart';
import 'package:fashionstore/presentations/address/update_address.dart';
import 'package:flutter/material.dart';

import 'package:fashionstore/core/constants.dart';
import 'package:fashionstore/presentations/checkout/widget/address_field.dart';
import 'package:fashionstore/presentations/checkout/widget/edit_address_button.dart';
import 'package:page_transition/page_transition.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.name,
    required this.address,
    required this.pincode,
    required this.state,
    required this.city,
    required this.phone,
    required this.email,
    required this.id,
  }) : super(key: key);
  final String name;
  final String address;
  final String pincode;
  final String state;
  final String city;
  final String phone;
  final String email;
  final String id;

  @override
  Widget build(BuildContext context) {
    var data = Address(
        id: id,
        name: name,
        pinCode: int.parse(pincode),
        permanentAddress: address,
        state: state,
        city: city,
        phone: int.parse(phone),
        email: email);
    var size = MediaQuery.of(context).size;
    return Material(
      elevation: 12,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      shadowColor: Colors.black,
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.250,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressField(id: 'Name', value: name),
              khieght10,
              AddressField(id: 'Address', value: address),
              khieght10,
              AddressField(id: 'Pincode', value: pincode),
              khieght10,
              AddressField(id: 'City', value: city),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      khieght10,
                      Padding(
                        padding: const EdgeInsets.only(right: 54.0),
                        child: AddressField(id: 'State', value: state),
                      ),
                      khieght10,
                      AddressField(id: 'Phone', value: phone),
                    ],
                  ),
                  const Spacer(),
                  EditButton(
                      name: 'Edit',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: EditAdressScreen(
                              data: data,
                            ),
                          ),
                        );
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
