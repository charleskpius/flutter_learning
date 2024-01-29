// import 'package:flutter/material.dart';

// String? validatePassword(String password) {

//   //Define your password complexity rules here
//   final passwordRegex = r'^(?=.*?[A-Z])(?=*?[a-z])(?=*?[0-9])(?=*?[!@#\$&*~]).{8,}$;

//   if(password.isEmpty) {
//     return 'Password is required';
//   } else if (!RegExp(passwordRegex).hasMatch(password)) {
//     return 'Password must be atleast 8 characters,contains upercase, lowercase, numbers and special characters';
//   } else {
//     return null;
//   }
// }

// String? errorMessage = validatePassword(userEnteredPassword);

// TextFormField(validator: (value) => validatePassword(value),)