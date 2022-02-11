// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke(
      json['icon_url'] as String,
      json['id'] as String,
      json['url'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'icon_url': instance.iconUrl,
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
    };

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      json['total'] as int,
      (json['result'] as List<dynamic>)
          .map((e) => Joke.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'result': instance.result,
    };

UnsplashSearch _$UnsplashSearchFromJson(Map<String, dynamic> json) =>
    UnsplashSearch(
      json['total'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => UnsplashPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnsplashSearchToJson(UnsplashSearch instance) =>
    <String, dynamic>{
      'total': instance.total,
      'results': instance.results,
    };

UnsplashPhoto _$UnsplashPhotoFromJson(Map<String, dynamic> json) =>
    UnsplashPhoto(
      Map<String, String>.from(json['links'] as Map),
      Map<String, String>.from(json['urls'] as Map),
      json['description'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$UnsplashPhotoToJson(UnsplashPhoto instance) =>
    <String, dynamic>{
      'links': instance.links,
      'urls': instance.urls,
      'description': instance.description,
      'name': instance.name,
    };
