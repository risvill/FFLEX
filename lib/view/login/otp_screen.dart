import 'package:email_otp/email_otp.dart';
import 'package:fflex/common_widget/round_button.dart';
import 'package:fflex/view/login/complete_profile_view.dart';
import 'package:fflex/view/login/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    required this.myauth,
    required this.email,
    required this.password,
  }) : super(key: key);
  final EmailOTP myauth;
  final String email;
  final String password;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpView()));
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.dialpad_rounded, size: 50),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Введите код",
            style: TextStyle(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Otp(
                otpController: otp1Controller,
              ),
              Otp(
                otpController: otp2Controller,
              ),
              Otp(
                otpController: otp3Controller,
              ),
              Otp(
                otpController: otp4Controller,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Должен прийти 4-х значный код",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
   
            
          RoundButton(
  title: "Подтвердить",
  onPressed: () async {
    bool isOTPVerified = await widget.myauth.verifyOTP(
      otp: otp1Controller.text +
          otp2Controller.text +
          otp3Controller.text +
          otp4Controller.text,
    );

    if (isOTPVerified) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteProfileView(),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ошибка! Повторите попытку заново"),
          ),
        );
      }
    }
  },
),

          
        ],
      ),
    );
  }
}