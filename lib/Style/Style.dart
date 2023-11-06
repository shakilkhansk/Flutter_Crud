import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const colorRed = Color.fromRGBO(255, 0, 0, 1.0);
const colorGreen = Color.fromRGBO(0, 155, 29, 1.0);
const colorDarkBlue = Color.fromRGBO(0, 43, 110, 1.0);
const colorBlack = Color.fromRGBO(0, 0, 0, 1.0);
const colorWhite = Color.fromRGBO(255, 255, 255, 1.0);

ButtonStyle myButtonStyle(){
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: const EdgeInsets.all(0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.transparent
  );
}
Ink mySuccessButtonChild(buttonChild){
  return Ink(
    decoration: BoxDecoration(
      color: colorGreen,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(buttonChild,style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18
      )),
    ),
  );
}

SvgPicture bgScreen(context){
  return SvgPicture.asset(
    'assets/images/bg.svg',
    alignment: Alignment.center,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.cover,
  );
}
DecoratedBox myDropDownStyle(child){
  return DecoratedBox(
    decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(color: colorBlack),
        borderRadius: BorderRadius.circular(4),
    ),
    child: Padding(padding: const EdgeInsets.only(left: 20,right: 20),child: child),
  );
}
InputDecoration myInputDecoration(label){
  return InputDecoration(
    label: Text(label),
    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: colorBlack)),
    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: colorGreen)),
    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: colorRed)),
    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: colorRed)),
    fillColor: colorWhite,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10)
  );
}
void toastSuccess(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorGreen,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void toastError(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorRed,
      textColor: Colors.white,
      fontSize: 16.0
  );
}