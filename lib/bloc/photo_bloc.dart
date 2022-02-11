import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/unsplash_api.dart';
import '../model/model.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc(this._api) : super(PhotoState([])) {
    on<Search>(_search);
  }
  final UnsplashApi _api;

  FutureOr<void> _search(Search event, Emitter<PhotoState> emit) async {
    emit(LoadingState([]));
    final photos = await _api.search(
        event.query, 'Client-ID sLyR5u2dbmVCHmGJpVHeRSlhcTtp-I_D4t5gs06wWdg');
    emit(PhotoState(photos.results));
  }
}
