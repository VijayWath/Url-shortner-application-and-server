part of 'url_shortner_bloc.dart';

@immutable
sealed class UrlShortnerEvent {}

final class UrlHomeInitialRequested extends UrlShortnerEvent {}

final class UrlHistoryRequested extends UrlShortnerEvent {
  final String shortId;

  UrlHistoryRequested({required this.shortId});
}

final class OpenUrlRequested extends UrlShortnerEvent {}

final class GetAllUrlsRequested extends UrlShortnerEvent {}
