import 'package:flutter/material.dart';

class SideMenuButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> menuKey;

  const SideMenuButton({super.key, required this.menuKey});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Abrir menu lateral",
      hint: "Toque duas vezes para abrir o menu de acessibilidade",
      button: true,
      excludeSemantics: true,
      child: ExcludeSemantics(
        child: FloatingActionButton(
          onPressed: () {
            menuKey.currentState?.openDrawer();
          },
          mini: true,
          shape: const CircleBorder(),
          child: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
