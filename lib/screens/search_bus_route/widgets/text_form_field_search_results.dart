import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/provider/theme_provider.dart';
import 'package:helfen_bus/screens/search_bus_route/widgets/text_form_field/microphone_button.dart';
import 'package:helfen_bus/themes/style/percentage_extension.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../themes/color/scheme.dart';
import '../../../../themes/style/text_styles.dart';
import '../../../components/auto_complete/card_results.dart';
import '../../../components/search_results/controller/text_search_controller_provider.dart';
import '../../../infra/http/services/google_maps/places_service.dart';

class TextFormFieldSearchResults extends StatefulWidget {
  final Scheme scheme;
  final ThemeProvider themeProvider;

  const TextFormFieldSearchResults(
      {super.key, required this.scheme, required this.themeProvider});

  @override
  State<TextFormFieldSearchResults> createState() =>
      _TextFormFieldSearchResultsState();
}

class _TextFormFieldSearchResultsState
    extends State<TextFormFieldSearchResults> {
  final PlacesService placesService = PlacesService();
  final SpeechToText _speech = SpeechToText();
  late TextEditingController _textController;
  bool _speechEnabled = false;

  TextSearchControllerProvider get _textSearchControllerProvider =>
      Provider.of<TextSearchControllerProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    await _speech.initialize();
    setState(() {});
  }

  void _startSpeechListen() async {
    await _speech.listen(onResult: _getResults);
    setState(() {});
  }

  void _getResults(SpeechRecognitionResult result) {
    setState(() {
      _textController.text = result.recognizedWords;
    });
    _searchPlaces(query: _textController.text);
  }

  void _stopSpeechListen() async {
    await _speech.stop();
  }

  void _searchPlaces({required String query}) {
    placesService.searchPlaces(query).then((results) {
      _textSearchControllerProvider.getResults(results);
    });
  }

  OutlineInputBorder _buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        width: 10,
        color: color,
      ),
    );
  }

  InputDecoration get _buildInputDecoration {
    return InputDecoration(
        labelText: "Pesquise aqui",
        labelStyle: widget.themeProvider.isDarkMode
            ? TextStyles.textDarkOnSurface(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.scheme.surfaceVariant,
              )
            : TextStyles.textLightOnSurface(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.scheme.surfaceVariant,
              ),
        filled: true,
        fillColor: widget.themeProvider.isDarkMode
            ? widget.scheme.onBackground
            : widget.scheme.onBackground,
        focusedBorder: _buildOutlineInputBorder(color: widget.scheme.outline),
        enabledBorder:
            _buildOutlineInputBorder(color: widget.scheme.outlineVariant));
  }

  TextStyle get _getTextFieldStyle => widget.themeProvider.isDarkMode
      ? TextStyles.textDarkOnSurface(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: widget.scheme.inverseSurface,
        )
      : TextStyles.textLightOnSurface(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: widget.scheme.inverseSurface,
        );

  Widget _buildSearchTextField(
      {required BuildContext context,
      required TextSearchControllerProvider search}) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 70.00.percent(),
      child: Semantics(
        label: "Campo de pesquisa",
        hint: "Digite aqui para pesquisar locais",
        textField: true,
        child: TextFormField(
          autofocus: true,
          controller: _textController,
          onChanged: (searchText) {
            _searchPlaces(query: searchText);
          },
          style: _getTextFieldStyle,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          decoration: _buildInputDecoration.copyWith(
            hintText: "Digite um local",
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: widget.scheme.surfaceVariant.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchPlaces = context.watch<TextSearchControllerProvider>();
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenSize.width * 10.00.percent(),
            ),
            _buildSearchTextField(context: context, search: searchPlaces),
            MicrophoneButton(
              isListening: _speech.isListening,
              onTap: () {
                if (_speech.isListening) {
                  _stopSpeechListen();
                } else {
                  _startSpeechListen();
                }
              },
            ),
          ],
        ),
        CardResult(
          context: context,
          search: searchPlaces,
        ),
        //  Text(data)
      ],
    );
  }
}
