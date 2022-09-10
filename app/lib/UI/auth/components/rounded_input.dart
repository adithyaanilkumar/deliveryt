import 'package:flutter/material.dart';
import 'package:gardenfth/Constants/auth_UI_constants.dart';
import 'package:gardenfth/UI/auth/components/text_firel_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(

      child: TextFormField(

//       onEditingComplete: _emaileditingcomplete(),
//        focusNode: _emailFocusNode,
        autocorrect: false,
        onChanged: (email) => onChanged,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: controller,
        validator: (val) =>
        !val.contains('@') ? "Invalid Email" : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "Email Address",
          hintText: hintText,
//                          errorText: !widget.emailValidator.isValid(_email) ? widget.Invalidemailerrortext : null ,
          icon: Icon(
            Icons.mail,
            color: kPrimaryColor,
          ),
        ),
      ),

//      child: TextField(
//        onChanged: onChanged,
//        decoration: InputDecoration(
//          icon: Icon(
//            icon,
//            color: kPrimaryColor,
//          ),
//          hintText: hintText,
//          border: InputBorder.none,
//        ),
//      ),
    );
  }
}