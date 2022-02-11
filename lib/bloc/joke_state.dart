part of 'joke_bloc.dart';

class JokeState {
  final String category;

  JokeState(this.category);
}

class LoadingState extends JokeState {
  LoadingState(String category) : super(category);
}

class JokeReady extends JokeState {
  final Joke joke;

  JokeReady(this.joke, category) : super(category);
}

class SearchResults extends JokeState {
  final SearchResult result;

  SearchResults(this.result, category) : super(category);
}
