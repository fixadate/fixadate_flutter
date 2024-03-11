import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  var logger = Logger();

  static LoginController get to => Get.find();

  void requestKakaoLogin() async {
    OAuthToken token;
    User KakaoUser;
    String oauthId;
    bool ifKakaoTalkInstalled;
    ifKakaoTalkInstalled = await isKakaoTalkInstalled();

    //APP LOGIN
    if (ifKakaoTalkInstalled == true) {
      logger.i("Kakao installed. Initializing KakaoTalk app");

      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        logger.i('카카오톡으로 로그인 성공 token: $token');
        KakaoUser = await kakaoGetUserInfo();

        oauthId = KakaoUser.id.toString();
        Map<String, dynamic> statusCodeNBody = await checkIfUserExists(oauthId);

        //user exists -> login and redirect to adate
        if (statusCodeNBody["statusCode"] == 200) {
          logger.i("Member exists on db. Logging in and redirecting to adate");
          //to develop
          //redirect to Adate
        }
        //user does not exist -> infoinput and redirect to adate
        else if (statusCodeNBody["statusCode"] == 401) {
          logger.i("Member does not exist on db. Redirecting to infoinput");
          //to develop
          //redirect to infoinput page with data: {"oauthId": oauthId, "oauthPlatform": "kakao"})));
        }
      } catch (error) {
        logger.i('카카오톡으로 로그인 실패 error: $error');
      }
    }
    //WEB LOGIN
    else if (ifKakaoTalkInstalled == false) {
      logger.i("Kakao not installed. Initializing app browser");

      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        logger.i('카카오계정으로 로그인 성공 token: $token');
        KakaoUser = await kakaoGetUserInfo();
        oauthId = KakaoUser.id.toString();
        Map<String, dynamic> statusCodeNBody = await checkIfUserExists(oauthId);

        //user exists -> login and redirect to adate
        if (statusCodeNBody["statusCode"] == 200) {
          logger.i("Member exists on db. Logging in and redirecting to adate");
          //to develop
          //redirect to Adate
        }
        //user does not exist -> infoinput and redirect to adate
        else if (statusCodeNBody["statusCode"] == 404) {
          logger.i("Member does not exist on db. Redirecting to infoinput");
          //to develop
          //redirect to infoinput page with data: {"oauthId": oauthId, "oauthPlatform": "kakao"})));
        }
        //error occurs -> error page(suggest returning to loginpage)
        else {
          //to develop
          //rediect to login error
        }

        // print(KakaoUser.properties.profile);
        // print(KakaoUser.kakaoAccount);
        // print(KakaoUser.kakaoAccount?.birthday);
        // print(KakaoUser.kakaoAccount?.gender);
        // print(KakaoUser.kakaoAccount?.profile?.profileImageUrl);


      } catch (error) {
        logger.i('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  void requestGoogleLogin() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

    }
  }

  void requestAppleLogin(){

  }

  Future<User> kakaoGetUserInfo() async {
    User user = await UserApi.instance.me();
    return user;
  }

  Future<Map<String, dynamic>> checkIfUserExists(String oauthId) async {
    const String url = 'http://3.37.141.38:8080/auth/member';
    final Map<String, String> headers = {
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> body = {
      'oauthId': oauthId
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    String bodyMessage = "";
    if(response.body.isNotEmpty) {
      bodyMessage = jsonDecode(utf8.decode(response.bodyBytes)).toString();
    }

    Map<String, dynamic> statusCodeNBody = {
      "statusCode" : response.statusCode,
      "body" : bodyMessage
    };

    logger.i(bodyMessage);
    return statusCodeNBody;
  }
}