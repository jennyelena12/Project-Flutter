import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUpperCase = false;
  bool isLowerCase = false;
  bool isSimbol = false;
  bool isNomor = false;
  final password = RandomPasswordGenerator();
  Color? passwordColor = null;
  String? passwordStatus = null;
  String? passwordOutput = null;
  TextEditingController panjangController = new TextEditingController();

  void generatePassword(int panjangKarakter) {
    passwordOutput = password.randomPassword(
        letters: isLowerCase,
        uppercase: isUpperCase,
        numbers: isNomor,
        specialChar: isSimbol,
        passwordLength: panjangKarakter.toDouble());
    double passwordStrength = password.checkPassword(password: passwordOutput!);
    if (passwordStrength < 0.3) {
      passwordColor = Colors.red;
      passwordStatus = "Weak Password";
    } else if (passwordStrength < 0.7) {
      passwordColor = Colors.blue;
      passwordStatus = "Strong Password";
    } else {
      passwordColor = Colors.green;
      passwordStatus = "Very Strong Password";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Elena's Password Generator",
                    style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 243, 177, 255)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upper Case"),
                      Switch(
                          value: isUpperCase,
                          onChanged: (value) {
                            setState(() {
                              isUpperCase = value;
                            });
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lower Case"),
                      Switch(
                          value: isLowerCase,
                          onChanged: (value) {
                            setState(() {
                              isLowerCase = value;
                            });
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Symbol"),
                      Switch(
                          value: isSimbol,
                          onChanged: (value) {
                            setState(() {
                              isSimbol = value;
                            });
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number"),
                      Switch(
                          value: isNomor,
                          onChanged: (value) {
                            setState(() {
                              isNomor = value;
                            });
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: panjangController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Character's Length",
                        border:
                            OutlineInputBorder(borderSide: new BorderSide())),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        generatePassword(
                            int.parse(panjangController.text.toString()));
                        setState(() {});
                      },
                      child: Text("Generate Password"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50))),
                  SizedBox(
                    height: 50,
                  ),
                  passwordOutput != null
                      ? Column(
                          children: [
                            Text("Your Password:"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              passwordOutput!,
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              passwordStatus!,
                              style: TextStyle(
                                  color: passwordColor != null
                                      ? passwordColor
                                      : Colors.black),
                            )
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
