import 'package:fflex/common_widget/round_button.dart';
import 'package:fflex/view/login/signup_view.dart';
import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  TextEditingController _feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              // onPressed: () async {
              //   // Добавьте здесь логику для удаления аккаунта
              //   // Например, вызов функции, которая удалит пользователя из базы данных
              //   await firebaseService.deleteUser().then((value) => {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const SignUpView(),
              //           ),
              //         )
              //       });
              // },
              onPressed: () async {
  // Show a confirmation dialog
  bool confirmDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Подтверждение на удаление"),
        content: Text("Вы точно хотите удалить свой аккаунт и данные?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User doesn't want to delete
            },
            child: Text("Отмена"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User confirmed deletion
            },
            child: Text("Удалить"),
          ),
        ],
      );
    },
  );

  // If the user confirmed deletion, then delete the account
  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpView(),
        ),
      );
},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.orange; // Цвет при наведении
                    }
                    return null;
                  },
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Удалить аккаунт',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Оставьте свой отзыв:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Введите ваш отзыв здесь...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            RoundButton(
              title: 'Отправить отзыв',
              onPressed: () {
                //fasdfklajsdklfjlasjdf SABRINAAA
                String feedback = _feedbackController.text;
                showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Закрыть'),
                                  ),
                                ],
                                title: const Text('Отзыв'),
                                contentPadding: const EdgeInsets.all(20.0),
                                content: const Text(
                                    'Ваш отзыв отправлен успешно!'),
                              ),
                            );
              },
            )
          ],
        ),
      ),
    );
  }
}