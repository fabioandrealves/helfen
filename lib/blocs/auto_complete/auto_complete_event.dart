part of 'auto_complete_bloc.dart';

abstract class AutoCompleteEvent extends Equatable {
  const AutoCompleteEvent();

  @override
  List<Object> get props => [];
}

class TextChanged extends AutoCompleteEvent {
  final String text;
  const TextChanged({required this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}

class PlaceSelected extends AutoCompleteEvent {
  final Place place;
  const PlaceSelected({required this.place});

  @override
  List<Object> get props => [];
}
