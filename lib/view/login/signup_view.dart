// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:fflex/common/colo_extension.dart';
import 'package:fflex/common_widget/round_button.dart';
import 'package:fflex/view/login/complete_profile_view.dart';
import 'package:fflex/view/login/login_view.dart';
import 'package:fflex/view/login/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isCheck = false;
  // final FirebaseService firebaseService = FirebaseService();
    final _formState = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmailVerified = false;
  late Timer timer;
  // final auth = FirebaseAuth.instance;
  // late FirebaseService user;
  late String email;
  late String password;
  EmailOTP myauth = EmailOTP();
  // late AuthCredential credential;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    //timer?.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  Future<void> registerButtonPressed() async {
    try {
      myauth.setConfig(
          appEmail: "fitflex@gmail.com",
          appName: "FitFlex",
          userEmail: emailController.text,
          otpLength: 4,
          otpType: OTPType.digitsOnly);

      bool otpSent = await myauth.sendOTP();
      handleRegistrationResult(otpSent);
    } catch (e) {
      print("Error: $e");
      // Handle errors as needed
    }
  }

  void handleRegistrationResult(bool otpSent) {
    if (otpSent) {
      showSnackBar("OTP has been sent");
      navigateToNextScreen();
    } else {
      showSnackBar("Oops, OTP send failed");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void navigateToNextScreen() {
    try {
      // Navigator.push(
      //   // context,
      //   // MaterialPageRoute(
      //   //   builder: (context) => OtpScreen(
      //   //     myauth: myauth,
      //   //     email: emailController.text.trim(),
      //   //     password: passwordController.text.trim(),
      //   //   ),
      //   // ),
      // );
    } catch (e) {
      print("Navigation Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Form(
          key:_formState,
          autovalidateMode: AutovalidateMode.always,
        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Эй привет,",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Создать аккаунт",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите почту';
                      }
                      if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return 'Введите корректный адрес почты';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Цвет обводки для неактивного состояния
                          width:
                              1.5, // Ширина обводки для неактивного состояния
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Почта',
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/img/email.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: TColor.gray,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(
                          color: TColor.errorColor,
                          width: 2.0, // Ширина границы для ошибки
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(
                          color: TColor.errorColor,
                          width: 2.0, // Ширина границы для ошибки
                        ),
                      ),
                      hintStyle: TextStyle(color: TColor.gray, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: TColor.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Цвет обводки для неактивного состояния
                          width:
                              1.5, // Ширина обводки для неактивного состояния
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Пароль',
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/img/lock.png",
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: TColor.gray,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      hintStyle: TextStyle(color: TColor.gray, fontSize: 14),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(
                          color: TColor.errorColor,
                          width: 2.0, // Ширина границы для ошибки
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                        borderSide: BorderSide(
                          color: TColor.errorColor,
                          width: 2.0, // Ширина границы для ошибки
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
               
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                        color: TColor.gray,
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Продолжая, вы принимаете нашу\nмолитву о помощи вам.",
                        style: TextStyle(color: TColor.gray, fontSize: 10),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.4,
                ),
                // RoundButton(
                //   title: "Регистрация",
                //   onPressed: () async {
                //     if (_formState.currentState!.validate()) {
                //       print("Button Pressed");
                //       await registerButtonPressed();
                //     }
                //   },
                // ),
                RoundButton(
                    title: "Register",
                    onPressed: () async {
                      myauth.setConfig(
                          appEmail: "fitflex@gmail.com",
                          appName: "FitFlex",
                          userEmail: emailController.text,
                          otpLength: 4,
                          otpType: OTPType.digitsOnly);
                await myauth.sendOTP();
                    if (await myauth.sendOTP() == true) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  content: Text("OTP has been sent"),
                 ));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(
                        myauth: myauth,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      ),
                    ));

                }
                  if (await myauth.sendOTP() == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                        ));
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpScreen(
                          myauth: myauth,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        ),
                      ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                        ));
                      }
                }),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                    Text(
                      "  Или  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // bool signInSuccess =
                        //     await FirebaseService().signInWithGoogle();

                        // if (signInSuccess) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const CompleteProfileView()),
                        //   );
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text("Google Sign-In Canceled"),
                        //     ),
                        //   );
                        // }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/google.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Уже имеете аккаунт? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Войти",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}
