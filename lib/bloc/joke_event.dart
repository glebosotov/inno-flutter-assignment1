part of 'joke_bloc.dart';

class JokeEvent {}

class GetJoke extends JokeEvent {
  final String? category;

  GetJoke({this.category});
}

class Search extends JokeEvent {
  final String query;

  Search(this.query);
}

class NewCategory extends JokeEvent {
  final String category;

  NewCategory(this.category);
}

class GetCategories extends JokeEvent {}
