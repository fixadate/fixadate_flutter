import 'package:fixadate_flutter/presentation/presenter/sign_up_controller.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/widget/w_page_route_button.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/widget/w_register_title_text.dart';
import 'package:fixadate_flutter/presentation/ui/widget/w_preivous.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

List<String> professionList = ["student", "option2", "option3"];

class SecondSignUpScreen extends StatefulWidget {
  const SecondSignUpScreen({super.key});

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
  String dropdownValue = professionList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 120),
              PreviousPageArrow(),
              RegisterTitleText(),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.blue),
                      // Adjust the border color as needed
                      color: Colors.white),
                  child: DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width.toInt() - 61,
                    // ***
                    initialSelection: professionList.first,
                    menuStyle: MenuStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.white)),
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      SignUpController.to.profession = value;
                      SignUpController.to.check();
                    },
                    dropdownMenuEntries: professionList
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                          trailingIcon: Icon(Icons.audiotrack));
                    }).toList(),
                  )),
              SizedBox(height: 40),
              PageRouteButton(
                text: "Next",
                backGroundColor: Color.fromRGBO(251, 42, 66, 1.0),
                textColor: Colors.white,
                onPressed: () {
                  Get.toNamed("/signup3");
                },
              ),
              PageRouteButton(
                text: "Skip",
                backGroundColor: Colors.transparent,
                textColor: Color.fromRGBO(251, 42, 66, 1.0),
                onPressed: () {
                  Get.toNamed("/signup3");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
