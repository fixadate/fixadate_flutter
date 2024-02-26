import 'package:fixadate_flutter/presentation/ui/sign_up/s_signup1.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/s_signup2.dart';
import 'package:fixadate_flutter/presentation/ui/sign_up/s_signup3.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../presentation/presenter/login_controller.dart';
import '../../presentation/ui/login/s_login.dart';
import '../../presentation/ui/login/s_login_error.dart';

List<GetPage>? getRoutes = [

//   GetPage(name: "/login", page: () => LoginScreen()),
//   GetPage(name: "/login/error", page: () => LoginErrorScreen()),
//   GetPage(name: "/signup1", page: () => FirstSignUpScreen()),
//   GetPage(name: "/signup2", page: () => SecondSignUpScreen()),
//   GetPage(name: "/signup3", page: () => ThirdSignUpScreen())
];

  GetPage(
    name: "/login",
    page: () => LoginScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => LoginController()),
    ),
  ),
  GetPage(name: "/loginError", page: () => LoginErrorScreen()),
  GetPage(name: "/signUp1", page: () => FirstSignUpScreen()),
  GetPage(name: "/signUp2", page: () => SecondSignUpScreen())
];

