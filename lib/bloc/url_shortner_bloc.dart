import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:url_shortner_service/models/responseModel.dart';
import 'package:url_shortner_service/models/urlModel.dart';
import 'package:url_shortner_service/models/userModel.dart';
import 'package:url_shortner_service/respositories/tokenRepository.dart';
import 'package:url_shortner_service/respositories/urlRepository.dart';

part 'url_shortner_event.dart';
part 'url_shortner_state.dart';

class UrlShortnerBloc extends Bloc<UrlShortnerEvent, UrlShortnerState> {
  final UrlRepository urlRepository;
  final TokenRepository tokenRepository;
  UrlShortnerBloc(this.urlRepository, this.tokenRepository)
      : super(UrlShortnerInitial()) {
    on<UrlHomeInitialRequested>(_onUrlHomeInitialRequested);
    on<UrlHistoryRequested>(_onUrlHistoryRequested);
    on<GetAllUrlsRequested>(_onGetAllUrlsRequested);
    on<UrlReload>(_onUrlReload);
  }

  void _onUrlHomeInitialRequested(event, emit) async {
    final token = await TokenRepository().getToken();
    if (token == null) {
      emit(AuthTokenNotFound());
      return;
    }
    ResponseModel _response = await UrlRepository().getUser(token);
    if (_response.data == null) {
      emit(
        AuthTokenNotFound(),
      );
      return;
    }
    ResponseModel _historyResponse = await UrlRepository().getAllurls();
    if (_historyResponse.data != null) {
      UserModel user = _response.data;
      List<UrlModel> list = _historyResponse.data;
      emit(
        UrlShortnerHome(user: user, list: list),
      );
      return;
    }
  }

  void _onUrlHistoryRequested(event, emit) async {
    ResponseModel _response = await urlRepository.getUrlHistory(event.shortId);
    if (_response.data == null) {
      emit(UrlFailuar(error: _response.error!));
      return;
    }
    emit(UrlHistorySuccess());
  }

  void _onGetAllUrlsRequested(event, emit) async {
    ResponseModel _response = await urlRepository.getAllurls();
    if (_response.data != null) {
      emit(
        GetAllUrlsSuccess(list: _response.data, user: event.user),
      );
      return;
    }
    emit(UrlFailuar(error: _response.error!));
  }
}

void _onUrlReload(event, emit) async {
  final token = await TokenRepository().getToken();
  if (token == null) {
    emit(AuthTokenNotFound());
    return;
  }
  ResponseModel _response = await UrlRepository().getUser(token);
  if (_response.data == null) {
    emit(
      AuthTokenNotFound(),
    );
    return;
  }
  ResponseModel _historyResponse = await UrlRepository().getAllurls();
  if (_historyResponse.data != null) {
    UserModel user = _response.data;
    List<UrlModel> list = _historyResponse.data;
    emit(
      UrlShortnerHome(user: user, list: list),
    );
    return;
  }
}
