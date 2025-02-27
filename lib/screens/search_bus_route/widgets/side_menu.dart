import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/provider/theme_provider.dart';
import 'package:helfen_bus/themes/style/percentage_extension.dart';

class SideMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> menuKey;
  final ThemeProvider themeProvider;

  const SideMenu({
    super.key,
    required this.themeProvider,
    required this.menuKey,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * 85.00.percent(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              "Alterar tema:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Semantics(
            label: "Alternar modo de alto contraste",
            hint: "Ativa ou desativa o alto contraste",
            child: ListTile(
              title: const Text(
                "Alto contraste",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Semantics(
                label: "Interruptor de alto contraste",
                hint: themeProvider.isDarkMode
                    ? "Toque para desativar."
                    : "Toque para ativar.",
                toggled: themeProvider.isDarkMode,
                child: Switch.adaptive(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                    menuKey.currentState?.closeDrawer();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
