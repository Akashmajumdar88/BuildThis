
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'commonStyles.dart';

class CommonTextField extends StatelessWidget {
  String hintText;
  TextInputType? inputType;
  TextEditingController cont;
  bool isForContactNumber ;
  bool obscureText ;
  bool read ;
  final VoidCallback onPressed;
  var prefixIcon,maxline,validation,sufix;
  CommonTextField({ Key? key,
    required this.cont,
    required this.hintText,
    this.inputType = TextInputType.name,
    this.maxline,
    this.validation,
    this.sufix,
    this.isForContactNumber=false,
    this.obscureText=false,
    this.read=false,
    required this.onPressed,
    this.prefixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      controller: cont,
      keyboardType: inputType,
      style: TextStyles.fillStyle,
      validator: validation,
      onTap: onPressed,
      readOnly: read,
      onEditingComplete: (){
        FocusScope.of(context).nextFocus();
      },
      inputFormatters:isForContactNumber? [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ]:[],
      obscureText :obscureText,
      decoration:InputDecoration(
        hintText: hintText,
        hintStyle: TextStyles.hintStyle,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: sufix,
        contentPadding: const EdgeInsets.all(14.0),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(color: Color(0xFF64748B), width: 0.4)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFD0D5DD), width: 0.4),
            borderRadius: BorderRadius.circular(4.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: inputBorder, width: 0.4),
            borderRadius: BorderRadius.circular(4.0)),
      ),
    );
  }
}