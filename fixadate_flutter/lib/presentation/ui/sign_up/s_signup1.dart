import 'package:fixadate_flutter/config/validator/validator.dart';
import 'package:fixadate_flutter/presentation/presenter/sign_up_controller.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/widget/w_page_route_button.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/widget/w_register_textformfield.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/widget/w_register_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger();
class FirstSignUpScreen extends StatefulWidget {
  const FirstSignUpScreen({super.key});

  @override
  State<FirstSignUpScreen> createState() => _FirstSignUpScreenState();
}

class _FirstSignUpScreenState extends State<FirstSignUpScreen> {
  TextEditingController nickTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController birthFieldControler = TextEditingController(
      text: "MM" + "                " + "DD" + "               " + "YYYY");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isMalePressed = true;
  bool _isFemalePressed = false;
  String _gender = '';
  DateTime dateTime = DateTime.now();
  bool _isBirthFocused = false;
  final initDate = DateFormat('yyyy-MM-dd').parse('1989-01-01');
  String _birth = '';
  List<String> formattedMonth = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  Color focusedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    Get.put(SignUpController());
    SignUpController.to.oauthId = Get.arguments[0];
    SignUpController.to.oauthPlatform = Get.arguments[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.5),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 125,
                ),
                RegisterTitleText(),
                RegisterTextFormField(
                  hintText: "닉네임을 입력해 주세요.",
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await SignUpController.to.RandomNick();
                      nickTextEditingController.text =
                          SignUpController.to.nick ?? "";
                    },
                    icon: const Text(
                      '\u{1F3B2}', // Unicode for the dice emoji
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  textEditingController: nickTextEditingController,
                  validator: validate(),
                ),
                const SizedBox(
                  height: 20,
                ),
                RegisterTextFormField(
                  hintText: "이름을 입력해 주세요.",
                  textEditingController: nameTextEditingController,
                  validator: validate(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        color: _isBirthFocused
                            ? focusedColor
                            : Colors.white, // Set the top border color
                        width: 0.5, // Set the top border width
                      ),
                      bottom: BorderSide(
                        color: _isBirthFocused
                            ? focusedColor
                            : Colors.white, // Set the bottom border color
                        width: 0.5, // Set the bottom border width
                      ),
                    )),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                      controller: birthFieldControler,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          _isBirthFocused = true;
                        });
                        showModalBottomSheet(
                            context: (context),
                            builder: (BuildContext context) {
                              return Container(
                                  height: 330,
                                  // color: Colors.white,
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent, // 모달 배경색
                                      borderRadius: BorderRadius.vertical(
                                        top:
                                            Radius.circular(46), // 모달 전체 라운딩 처리
                                      )),
                                  //CUPERTINODATEPICKER (FOLDING)
                                  child: Column(
                                    children: [
                                      SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("  "),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: Colors.grey[300],
                                            ),
                                            child: Text(
                                              "  Month  ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ),
                                          Text("           "),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: Colors.grey[300],
                                            ),
                                            child: Text(
                                              "  Day  ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ),
                                          Text("    "),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: Colors.grey[300],
                                            ),
                                            child: Text(
                                              "  Year  ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: CupertinoDatePicker(
                                          minimumYear: 1900,
                                          maximumYear: 2024,
                                          initialDateTime: initDate,
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: (dateTime) {
                                            String formattedDate =
                                                DateFormat('MM-dd-yyyy')
                                                    .format(dateTime);
                                            //logger.i(formattedDate);
                                            int month = int.parse(
                                                formattedDate.split("-")[0]);;
                                            formattedDate =
                                                formattedMonth[month - 1] +
                                                    "                " +
                                                    formattedDate
                                                        .split("-")[1] +
                                                    "               " +
                                                    formattedDate.split("-")[2];
                                            birthFieldControler.text =
                                                formattedDate;
                                          },
                                        ),
                                      ),
                                    ],
                                  ));
                            }).then(
                          (value) => setState(() {
                            _isBirthFocused = false;
                          }),
                        );
                      },
                      onSaved: (value) {
                        String strMonth = value!.substring(0, 3);
                        int intMonth = formattedMonth.indexOf(strMonth) + 1;
                        String month = intMonth.toString();
                        if (month.length < 2) {
                          month = "0" + month;
                        }
                        value = value!.replaceAll(" ", "");
                        value = month + value.substring(3);
                        _birth = value;
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //MALE BUTTON
                    Expanded(
                        flex: 41,
                        child: Container(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // Toggle the state of the button
                                _isMalePressed = true;
                                _isFemalePressed = false;
                              });
                            },
                            style: _isMalePressed
                                ? ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(251, 42, 66, 1.0),
                                    // Change color when pressed
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)))
                                : ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                            child: Text(
                              'Male',
                              style: _isMalePressed
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white)
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.black, fontSize: 15),
                            ),
                          ),
                        )),

                    const Expanded(
                      child: SizedBox(width: 25),
                      flex: 8,
                    ),

                    //FEMALE BUTTON
                    Expanded(
                      flex: 41,
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isFemalePressed = true;
                              _isMalePressed = false;
                            });
                          },
                          style: _isFemalePressed
                              ? ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(251, 42, 66, 1.0),
                                  // Change color when pressed
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))
                              : ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            'Female',
                            style: _isFemalePressed
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                PageRouteButton(
                  text: "Next",
                  backGroundColor: Color.fromRGBO(251, 42, 66, 1.0),
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_isFemalePressed) {
                        _gender = "Female";
                      } else if (_isMalePressed) {
                        _gender = "Male";
                      }
                      SignUpController.to.nick = nickTextEditingController.text;
                      SignUpController.to.name = nameTextEditingController.text;
                      SignUpController.to.gender = _gender;
                      SignUpController.to.birth = _birth;
                      SignUpController.to.check();
                      Get.toNamed("/signup2");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
