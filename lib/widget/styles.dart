import 'package:flutter/material.dart';
import 'package:zartek/utils/Colors.dart';

TextStyle poppinsBoldText(){
  return const TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      fontFamily: 'Poppins Bold'
  );
}


TextStyle poppinsRegularText(){
  return const TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontFamily: 'Poppins Regular'
  );
}
TextStyle poppinsRegularTextRed(){
  return const TextStyle(
      color: redColor,
      fontSize: 14,
      fontFamily: 'Poppins Regular'
  );
}

TextStyle poppinsMediumText(){
  return const TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'Poppins Medium'
  );
}

TextStyle poppinsSemiBoldText(){
  return const TextStyle(
      color: blackColor,
      fontSize: 14,
      fontFamily: 'Poppins Semi Bold'
  );
}

TextStyle poppinsSemiBoldWhiteText(){
  return const TextStyle(
      color: whiteColor,
      fontSize: 14,
      fontFamily: 'Poppins Semi Bold'
  );
}
TextStyle poppinsLightText(){
  return const TextStyle(
      color: blackColor,
      fontSize: 12,
      fontFamily: 'Poppins Light'
  );
}
