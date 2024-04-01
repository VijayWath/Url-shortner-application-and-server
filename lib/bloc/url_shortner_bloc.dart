import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'url_shortner_event.dart';
part 'url_shortner_state.dart';

class UrlShortnerBloc extends Bloc<UrlShortnerEvent, UrlShortnerState> {
  UrlShortnerBloc() : super(UrlShortnerInitial()) {
    on<UrlShortnerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
