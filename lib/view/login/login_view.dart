// ignore_for_file: avoid_print

import 'package:fflex/common/colo_extension.dart';
import 'package:fflex/common_widget/round_button.dart';
import 'package:fflex/models/signIn.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: SafeArea(
              child: Container(
                height: media.height * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Эй привет,",
                      style: TextStyle(color: TColor.gray, fontSize: 16),
                    ),
                    Text(
                      "С возвращением!",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: TColor.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        // controller: emailController,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Введите почту';
                        //   }
                        //   if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        //       .hasMatch(value)) {
                        //     return 'Введите корректный адрес почты';
                        //   }
                        //   return null;
                        // },
                        controller: usernameController,
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
                          hintText: 'Логин',
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
                          hintStyle:
                              TextStyle(color: TColor.gray, fontSize: 14),
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
                        // controller: passwordController,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        // obscureText: !_isPasswordVisible,
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
                          hintStyle:
                              TextStyle(color: TColor.gray, fontSize: 14),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Забыли пароль?",
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 12,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    RoundButton(
                      title: "Войти",
                      onPressed: () async {
                        final username = usernameController.text;
                        final password = passwordController.text;

                        if (username.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, заполните все поля'),
                            ),
                          );
                          return;
                        }

                        // Вызываем метод postSignIn для выполнения запроса на сервер
                        final token = 'temporary-token-for-testing'; // Временное значение токена для тестирования
                        final userData = await postSignIn(username, password, token);

                        if (userData != null) {
                          // Вход выполнен успешно, обрабатываем данные, например, сохраняем в хранилище, и т.д.
                          print('Вход выполнен успешно: $userData');

                          // Здесь можно выполнить какие-то действия, например, переход на другой экран
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Неверное имя пользователя или пароль'),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    Row(
                     
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
                          onTap: () {
                            // FirebaseService().signInWithGoogle();
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
                      ],
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Еще нет аккаунта? ",
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Регистрация",
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
        ));
  }
}
