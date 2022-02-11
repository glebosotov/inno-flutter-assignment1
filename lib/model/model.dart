import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Joke {
  @JsonKey(name: 'icon_url')
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  Joke(this.iconUrl, this.id, this.url, this.value);

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
}

@JsonSerializable()
class SearchResult {
  final int total;
  final List<Joke> result;

  SearchResult(this.total, this.result);

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@JsonSerializable()
class UnsplashSearch {
  final int total;
  final List<UnsplashPhoto> results;

  UnsplashSearch(this.total, this.results);

  factory UnsplashSearch.fromJson(Map<String, dynamic> json) =>
      _$UnsplashSearchFromJson(json);
}

@JsonSerializable()
class UnsplashPhoto {
  final Map<String, String> links;
  final Map<String, String> urls;
  final String? description;
  final String? name;

  UnsplashPhoto(this.links, this.urls, this.description, this.name);

  factory UnsplashPhoto.fromJson(Map<String, dynamic> json) =>
      _$UnsplashPhotoFromJson(json);
}
