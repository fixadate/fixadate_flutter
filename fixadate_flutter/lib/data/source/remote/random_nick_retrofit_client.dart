import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';


part 'random_nick_retrofit_client.g.dart';
// @RestApi(baseUrl: "https://api.fixadate.app/")
@RestApi(baseUrl: "https://api.fixadate.app")
abstract class RandomNickRestClient{
  factory RandomNickRestClient(Dio dio, {String baseUrl}) = _RandomNickRestClient;

  @GET("/member/nickname")
  Future<String> getRandomNick();
}