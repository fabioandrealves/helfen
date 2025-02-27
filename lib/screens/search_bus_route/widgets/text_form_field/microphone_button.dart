import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MicrophoneButton extends StatelessWidget {
  final Function() onTap;
  final bool isListening;

  const MicrophoneButton({
    super.key,
    required this.onTap,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Semantics(
      label: isListening ? "Parar gravação de voz" : "Iniciar gravação de voz",
      button: true,
      child: Tooltip(
        message: isListening ? "Parar gravação" : "Iniciar gravação",
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              isListening ? Icons.mic_off : Icons.mic,
              size: 30.0,
              color: themeProvider.isDarkMode
                  ? (isListening ? Colors.red : Colors.white)
                  : (isListening ? Colors.red : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
