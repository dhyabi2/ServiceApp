import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

textField(
    {required TextEditingController? controller,
    int? maxLength,
    TextInputType? keyboardType,
    String? prefix,
    String? suffix,
    required String hintText,
    String? Function(String?)? validator}) {
  return TextFormField(
    keyboardType: keyboardType,
    controller: controller,
    maxLength: maxLength,
    validator: validator,
    style: TextStyle(
      fontSize: Get.height / 50,
      color: darktext,
    ),
    decoration: InputDecoration(
      counterText: "",
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, fontFamily: CustomStrings.dnmed, color: greyText2),
      prefixIcon: prefix == null
          ? null
          : Image.asset(
              prefix ?? "",
              scale: prefix == ImageAssets.loc2 ? 1 : 2,
            ),
      suffixIcon: suffix == null
          ? null
          : Image.asset(
              suffix ?? "",
              scale: suffix == ImageAssets.loc1 ? 1 : 2,
            ),
      contentPadding: EdgeInsets.symmetric(vertical: Get.height / 70, horizontal: Get.width / 30),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightgrey),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightgrey,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

appButton({Function()? onTap, String? title, Color? clr}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: Get.height / 16,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: clr),
      child: Center(
        child: Text(
          title!.tr,
          style: TextStyle(
            color: white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: CustomStrings.dnmed,
          ),
        ),
      ),
    ),
  );
}

appButton2({
  required GestureTapCallback onPressed,
  required String title,
  required Color borderColor,
  required Color textColor,
  Color? bgColor,
  String? img,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: Get.height / 17,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4), border: Border.all(color: borderColor)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            img == null
                ? const SizedBox()
                : Image.asset(
                    img,
                    scale: 2,
                  ),
            SizedBox(
              width: img == null ? 0 : 5,
            ),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: CustomStrings.dnmed,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
