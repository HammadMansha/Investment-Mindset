import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../utils/app_libraries.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Color? fillcolor;
  final Color? bordercolor;
  final bool isTextHidden;
  final String? hintText;
  final IconData? buttonIcon;
  final IconData? prefixIcon;
  final bool? togglePassword;
  final int? maxLength;
  final int maxLine;
  final Function()? toggleFunction;
  final IconData? toggleIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;
  final Function()? prefixIconTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focus;
  final TextInputAction? textInputAction;
  final Color? hintTextColor;

  const CommonTextField(
      {Key? key,
      @required this.controller,
      this.validator,
      this.bordercolor,
      this.labelText,
      this.fillcolor,
      this.hintText,
      this.isTextHidden = false,
      this.buttonIcon,
      this.prefixIcon,
      this.onChanged,
      this.togglePassword = false,
      this.toggleFunction,
      this.toggleIcon,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.maxLength,
      this.maxLine = 1,
      this.readOnly,
      this.onTap,
      this.inputFormatters,
      this.prefixIconTap,
      this.hintTextColor,
      this.focus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: TextFormField(
        cursorColor: AppColors.commonColor,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        obscureText: isTextHidden,
        readOnly: readOnly == null ? false : true,
        onTap: onTap,
        maxLength: maxLength,
        maxLines: maxLine,
        focusNode: focus,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          
          prefixIcon: prefixIcon != null
              ? GestureDetector(
                  onTap: prefixIconTap,
                  child: Icon(
                    prefixIcon,
                    color: Colors.black,
                    size: 20.0,
                  ),
                )
              : null,
          suffixIcon: togglePassword!
              ? GestureDetector(
                  onTap: toggleFunction,
                  child: Icon(
                    toggleIcon,
                    color: AppColors.commonColor,
                  ))
              : null,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.commonColor2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.commonColor2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: hintText,
          helperStyle: TextStyle(
            letterSpacing: 0.4,
            color: const Color(0xff1E1989).withOpacity(0.3),
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            
            letterSpacing: 0.4,
            color: const Color(0xff1E1989).withOpacity(0.3),
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
              letterSpacing: 0.4, color: Colors.black, fontSize: 10.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        style: const TextStyle(
            letterSpacing: 0.4,
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400),
        controller: controller,
        validator: validator,
      ),
    );
  }
}

// < ------------------ AppBar textfield -------------------- >
class CommonTextFormField1 extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? obsecure;
  final TextInputType? type;
  final int? lines;
  final VoidCallback? onPressed;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  // ignore: use_key_in_widget_constructors
  const CommonTextFormField1(
      {this.controller,
      this.hintText,
      this.labelText,
      this.obsecure,
      this.type,
      this.lines,
      this.onPressed,
      this.onChanged,
      this.onTap,
      this.readOnly = false,
      this.onFieldSubmitted});

  @override
  // ignore: library_private_types_in_public_api
  _CommonTextFormField1State createState() => _CommonTextFormField1State();
}

class _CommonTextFormField1State extends State<CommonTextFormField1> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      style: const TextStyle(color: AppColors.whiteColor),
      maxLines: 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      keyboardType: widget.type,
      onChanged: widget.onChanged,
      cursorColor: AppColors.whiteColor,
      controller: widget.controller,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        // ignore: deprecated_member_use
        suffixIcon: InkWell(
          onTap: widget.onPressed,
          // ignore: deprecated_member_use
          child: const Icon(FontAwesomeIcons.search,
              size: 15, color: AppColors.whiteColor),
        ),
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: widget.hintText!.toUpperCase(),
        labelText: widget.labelText,
        focusColor: Colors.red,
        hintStyle: TextStyle(
            color: const Color(0xffF6F6F6).withOpacity(0.3),
            fontSize: 13,
            fontWeight: FontWeight.w400),
        errorStyle: const TextStyle(color: Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(78),
          borderSide: const BorderSide(color: Color(0xffC7C7C7)),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(78),
          borderSide: const BorderSide(color: Color(0xffC7C7C7)),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(78),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(78),
          borderSide: const BorderSide(color: Colors.red),
          gapPadding: 10,
        ),
      ),
    );
  }

  
}
class CommonTextField2 extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final Color? fillcolor;
  final Color? bordercolor;
  final bool isTextHidden;
  final String? hintText;
  final IconData? buttonIcon;
  final IconData? prefixIcon;
  final bool? togglePassword;
  final int? maxLength;
  final int maxLine;
  final Function()? toggleFunction;
  final IconData? toggleIcon;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;
  final Function()? prefixIconTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focus;
  final TextInputAction? textInputAction;
  final Color? hintTextColor;

  const CommonTextField2(
      {Key? key,
      @required this.controller,
      this.validator,
      this.bordercolor,
      this.labelText,
      this.fillcolor,
      this.hintText,
      this.isTextHidden = false,
      this.buttonIcon,
      this.prefixIcon,
      this.onChanged,
      this.togglePassword = false,
      this.toggleFunction,
      this.toggleIcon,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.maxLength,
      this.maxLine = 1,
      this.readOnly,
      this.onTap,
      this.inputFormatters,
      this.prefixIconTap,
      this.hintTextColor,
      this.focus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: TextFormField(
        cursorColor: AppColors.commonColor,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        obscureText: isTextHidden,
        readOnly: readOnly == null ? false : true,
        onTap: onTap,
        maxLength: maxLength,
        maxLines: maxLine,
        focusNode: focus,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          
          prefixIcon: prefixIcon != null
              ? GestureDetector(
                  onTap: prefixIconTap,
                  child: Icon(
                    prefixIcon,
                    color: Colors.black,
                    size: 20.0,
                  ),
                )
              : null,
          suffixIcon: togglePassword!
              ? GestureDetector(
                  onTap: toggleFunction,
                  child: Icon(
                    toggleIcon,
                    color: AppColors.commonColor,
                  ))
              : null,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.commonColor2),
          ),
          
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.commonColor2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hintText: hintText,
          helperStyle: TextStyle(
            letterSpacing: 0.4,
            color: const Color(0xff1E1989).withOpacity(0.3),
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.only(left: 15,bottom: 15),
          hintStyle: TextStyle(
            
            letterSpacing: 0.4,
            color: const Color(0xff1E1989).withOpacity(0.3),
            fontSize: 13.0,
            fontWeight: FontWeight.w400,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
              letterSpacing: 0.4, color: Colors.black, fontSize: 10.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        style: const TextStyle(
            letterSpacing: 0.4,
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400),
        controller: controller,
        validator: validator,
      ),
    );
  }
}
