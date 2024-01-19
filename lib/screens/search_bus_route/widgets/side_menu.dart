import 'package:flutter/material.dart';
import 'package:helfen_bus/infra/provider/theme_provider.dart';

class SideMenu extends StatelessWidget {
  final ThemeProvider themeProvider;
  const SideMenu({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Alterar tema:")),
          ListTile(
            leading: Icon(
              themeProvider.isDarkMode == true
                  ? Icons.brightness_5
                  : Icons.brightness_5_outlined,
            ),
            title: const Text("Alto contraste"),
            trailing: Switch.adaptive(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
