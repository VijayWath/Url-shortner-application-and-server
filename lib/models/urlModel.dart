import 'package:url_shortner_service/models/historyModel.dart';

class UrlModel {
  final String shortId;
  final String redirectUrl;
  final String userId;
  final List<HistoryModel> history;

  UrlModel(
      {required this.shortId,
      required this.redirectUrl,
      required this.userId,
      required this.history});
}
