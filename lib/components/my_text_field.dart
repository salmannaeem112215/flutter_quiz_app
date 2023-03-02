import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.controler,
    required this.hintText,
    required this.obsecureText,
    required this.validator,
    this.borderRadius,
    this.enabled=true,
  });

  final TextEditingController? controler;
  final String hintText;
  final bool obsecureText;
  final bool enabled;
  final String? Function(String?) validator;
  final BorderRadius? borderRadius;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controler,
      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: (widget.borderRadius != null)
              ? widget.borderRadius!
              : BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: (widget.borderRadius != null)
              ? widget.borderRadius!
              : BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: (widget.borderRadius != null)
              ? widget.borderRadius!
              : BorderRadius.circular(5),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: () => setState(() {
            hidePassword = !hidePassword;
          }),
          child: widget.obsecureText
              ? Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  // color: Colors.grey,
                )
              : const SizedBox(),
        ),
      ),
      cursorColor: Colors.grey.shade700,
      obscureText: widget.obsecureText && hidePassword,
      validator: (value) => widget.validator(value),
    );
  }
}
