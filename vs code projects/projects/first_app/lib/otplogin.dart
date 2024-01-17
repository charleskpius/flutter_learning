// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pin_input_text_field/pin_input_text_field.dart';

// class OTPLoginPage extends StatefulWidget {
//   @override
//   _OTPLoginPageState createState() => _OTPLoginPageState();
// }

// class _OTPLoginPageState extends State<OTPLoginPage> {
//   TextEditingController _mobileNumberController = TextEditingController();
//   TextEditingController _pinEditingController = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId = ""; // Declare _verificationId at the class level

//   bool _showOTPField = false; // Flag to control the visibility of the OTP field

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Login Page'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: _mobileNumberController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Enter Mobile Number',
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (_showOTPField) // Show OTP field only when needed
//                 PinInputTextField(
//                   pinLength: 6,
//                   controller: _pinEditingController,
//                   autoFocus: true,
//                   textInputAction: TextInputAction.done,
//                   decoration: UnderlineDecoration(
//                     textStyle: TextStyle(fontSize: 20, color: Colors.black),
//                     colorBuilder:
//                         PinListenColorBuilder(Colors.black, Colors.blue),
//                   ),
//                   onSubmit: (pin) {
//                     // Handle OTP submission here
//                     print("Entered OTP: $pin");
//                     _signInWithOTP(pin);
//                   },
//                 ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   String mobileNumber = _mobileNumberController.text;
//                   // Trigger OTP verification logic here with mobileNumber
//                   print("Verify OTP for mobile number: $mobileNumber");
//                   _verifyPhoneNumber(mobileNumber);
//                 },
//                 child: Text(_showOTPField ? 'Resend OTP' : 'Send OTP'),
//               ),
//               SizedBox(height: 20),
//               if (!_showOTPField) // Show OTP field only when needed
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _showOTPField = true; // Show the OTP field
//                     });
//                   },
//                   child: Text('Enter OTP'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _verifyPhoneNumber(String phoneNumber) async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Automatic verification for some devices
//         await _auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print("Verification Failed: $e");
//         // Handle the error
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         // Handle the OTP code sent to the user
//         _verificationId = verificationId; // Store the verificationId
//         setState(() {
//           _showOTPField = true; // Show the OTP field
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Called when the auto-retrieval of the OTP code is timed out
//       },
//     );
//   }

//   Future<void> _signInWithOTP(String otp) async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: otp,
//       );

//       await _auth.signInWithCredential(credential);
//       print("Successfully signed in with OTP");
//       // Add navigation logic to the next screen
//     } catch (e) {
//       print("Error signing in with OTP: $e");
//       // Handle sign-in error
//     }
//   }
// }
