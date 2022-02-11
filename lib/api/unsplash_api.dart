import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/model.dart';

part 'unsplash_api.g.dart';

@RestApi(baseUrl: 'https://api.unsplash.com/')
abstract class UnsplashApi {
  factory UnsplashApi(Dio dio) = _UnsplashApi;

  @GET('/search/photos')
  Future<UnsplashSearch> search(@Query('query') String query,
      @Header('Authorization') String accessToken);
}
