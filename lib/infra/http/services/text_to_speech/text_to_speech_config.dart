import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts tts = FlutterTts();

  FlutterTtsConfig() {
    tts.setLanguage("pt-BR");
    // Adicione outras configurações, se necessário
  }

  Future<void> setVoice() async {
    await tts.setVoice({"name": "pt-br-x-afs#male_1-local", "locale": "pt-BR"});
  }

  Future<void> speak(String text) async {
    //await _flutterTts.setVoice("pt-br-x-afs#male_1-local");
    await tts.setSpeechRate(0.8);
    await tts.speak(text);
  }
}
