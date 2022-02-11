part of 'photo_bloc.dart';

class PhotoState {
  final List<UnsplashPhoto> photos;

  PhotoState(this.photos);
}

class LoadingState extends PhotoState {
  LoadingState(List<UnsplashPhoto> photos) : super(photos);
}
