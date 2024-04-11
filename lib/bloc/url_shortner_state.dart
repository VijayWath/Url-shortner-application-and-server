part of 'url_shortner_bloc.dart';

@immutable
sealed class UrlShortnerState {}

final class UrlShortnerInitial extends UrlShortnerState {}

final class UrlShortnerHome extends UrlShortnerState {
  final UserModel user;
  final List<UrlModel> list;

  UrlShortnerHome({required this.user, required this.list});
}

final class UrlFailuar extends UrlShortnerState {
  final String error;

  UrlFailuar({required this.error});
}

final class UrlHistorySuccess extends UrlShortnerState {}

final class UrlCreateSuccess extends UrlShortnerState {
  final UrlModel newUrl;

  UrlCreateSuccess({required this.newUrl});
}

final class GetAllUrlsSuccess extends UrlShortnerState {
  final List<UrlModel> list;
  final UserModel user;

  GetAllUrlsSuccess({required this.list, required this.user});
}

final class UrlCreationLoading extends UrlShortnerState {}

final class AuthTokenNotFound extends UrlShortnerState {}
