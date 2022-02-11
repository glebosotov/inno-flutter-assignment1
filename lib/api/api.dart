import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/model.dart';

part 'api.g.dart';

@RestApi()
abstract class NetworkApi {
  factory NetworkApi(Dio dio, {String? baseUrl}) = _NetworkApi;

  @GET('/jokes/random')
  Future<Joke> getRandomJoke(@Query('category') String? category);

  @GET('/jokes/categories')
  Future<List<String>> getCategories();

  @GET('/jokes/search')
  Future<SearchResult> search(@Query('query') String query);
}
