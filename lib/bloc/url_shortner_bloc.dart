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
  }

  void _onUrlHomeInitialRequested(event, emit) async {
    final token = await TokenRepository().getToken();
    if (token == null) {
      emit(AuthTokenNotFound());
      return;
    }
    emit(UrlLoading());
    ResponseModel _response = await UrlRepository().getUser(token);
    if (_response.data == null) {
      emit(
        AuthTokenNotFound(),
      );
      return;
    }
    UserModel user = _response.data;
    emit(UrlShortnerHome(user: user));
  }

  void _onUrlHistoryRequested(event, emit) async {
    emit(UrlLoading());
    ResponseModel _response = await urlRepository.getUrlHistory(event.shortId);
    if (_response.data == null) {
      emit(UrlFailuar(error: _response.error!));
      return;
    }
    emit(UrlHistorySuccess());
  }

  void _onGetAllUrlsRequested(event, emit) async {
    emit(UrlLoading());
    ResponseModel _response = await urlRepository.getAllurls();
    if (_response.data == null) {
      emit(UrlFailuar(error: _response.error!));
      return;
    }
    emit(UrlHistorySuccess());
  }
}
