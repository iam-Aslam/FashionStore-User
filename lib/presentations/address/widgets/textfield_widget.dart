import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.size,
    required this.fieldName,
    this.hideField = false,
    this.numPad = false,
    this.colorValue = Colors.white,
    required this.textController,
    this.validator,
    this.hintName,
    this.enabled = true,
  }) : super(key: key);

  final Size size;
  final String fieldName;
  final bool hideField;
  final bool enabled;
  final bool numPad;

  final Color colorValue;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final String? hintName;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> eyeNotifier = ValueNotifier(hideField);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.grey),
              color: colorValue,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    fieldName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: eyeNotifier,
                        builder: (context, hideField, child) => TextFormField(
                          validator: validator,
                          enabled: enabled,
                          autovalidateMode: AutovalidateMode.disabled,
                          controller: textController,
                          obscureText: hideField,
                          keyboardType: numPad ? TextInputType.phone : null,
                          maxLines: hideField ? 1 : null,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: hintName ?? "Type here",
                            border: InputBorder.none,
                            labelStyle: const TextStyle(
                              color: Colors.transparent,
                            ),
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: size.width * 0.02,
            top: size.height * 0.035,
            child: SizedBox(
              child: hideField
                  ? GestureDetector(
                      onTap: () {
                        eyeNotifier.value = !eyeNotifier.value;
                      },
                      child: ValueListenableBuilder(
                        valueListenable: eyeNotifier,
                        builder: (context, hideOrShow, child) => hideOrShow
                            ? const Icon(Icons.hide_source)
                            : const Icon(Icons.slideshow_sharp),
                      ),
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
