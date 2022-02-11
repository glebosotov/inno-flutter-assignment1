import 'dart:async';

import 'package:chuck/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  static const String defaultCategoryName = 'Empty';
  JokeBloc(this._api) : super(LoadingState(defaultCategoryName)) {
    on<GetJoke>(_getJoke);
    on<Search>(_search);
    on<GetCategories>(_getCategories);
    on<NewCategory>(_newCategory);

    add(GetCategories());
  }

  final NetworkApi _api;
  List<String> categories = [];

  FutureOr<void> _getJoke(GetJoke event, Emitter<JokeState> emit) async {
    final String? category =
        event.category == defaultCategoryName ? null : event.category;
    emit(LoadingState(state.category));
    final joke = await _api.getRandomJoke(category);
    emit(JokeReady(joke, category ?? defaultCategoryName));
  }

  FutureOr<void> _search(Search event, Emitter<JokeState> emit) async {
    emit(LoadingState(defaultCategoryName));
    final jokes = await _api.search(event.query);
    emit(SearchResults(jokes, defaultCategoryName));
  }

  FutureOr<void> _getCategories(
      GetCategories event, Emitter<JokeState> emit) async {
    emit(LoadingState(state.category));
    List<String> apiCategories = await _api.getCategories();
    apiCategories.insert(0, defaultCategoryName);
    categories = apiCategories;
    add(GetJoke());
  }

  FutureOr<void> _newCategory(NewCategory event, Emitter<JokeState> emit) {
    add(GetJoke(category: event.category));
  }
}
