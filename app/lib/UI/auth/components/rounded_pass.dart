import 'package:flutter/material.dart';
import 'package:gardenfth/Constants/auth_UI_constants.dart';
import 'package:gardenfth/UI/auth/components/text_firel_container.dart';


class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Function submit;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool obscure;
  final Function showPass;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.submit,
    this.focusNode,
    this.controller,
    this.obscure,
    this.showPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onEditingComplete: submit,
        focusNode: focusNode,
        controller: controller,
        onChanged: (password) => onChanged,
        obscureText: obscure,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
//                          errorText: !widget.passValidator.isValid(_pass) ? widget.Invalidpasserrortext : null ,
          suffixIcon: GestureDetector(
            onTap: showPass,
            child: Icon(Icons.visibility),
          ),
          labelText: "Password",
          border: InputBorder.none,
          hintText: "Enter password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}