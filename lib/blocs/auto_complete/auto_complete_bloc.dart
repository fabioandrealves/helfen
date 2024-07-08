import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../infra/http/services/google_maps/places_service.dart';
import '../../model/google_maps/places/place.dart';

part 'auto_complete_event.dart';
part 'auto_complete_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class AutoCompleteBloc extends Bloc<AutoCompleteEvent, AutoCompleteState> {
  final PlacesService placeSearchService = PlacesService();
  List<Place>? results = [];

  AutoCompleteBloc() : super(AutoCompleteEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<AutoCompleteState> emit,
  ) async {
    final query = event.text;
    if (query.length < 2) return emit(AutoCompleteEmpty());

    emit(AutoCompleteLoading());

    results = await placeSearchService.searchPlaces(query);
    if (results != null) {
      emit(AutoCompleteSuccess(results!));
    } else {
      const AutoCompleteError('something went wrong');
    }
  }
}
