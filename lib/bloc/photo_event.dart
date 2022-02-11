part of 'photo_bloc.dart';

class PhotoEvent {}

class Search extends PhotoEvent {
  final String query;

  Search(this.query);
}
