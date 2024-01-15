import 'package:flutter/material.dart';
import 'package:notesapp/screens/settings_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        //drawer header
        const Padding(
          padding: EdgeInsets.only(
            top: 40,
          ),
          child: DrawerHeader(
            child: Text("NOTES"),
          ),
        ),
        //home tile
         ListTile(
          leading:const  Icon(Icons.home),
          title: const Text("HOME"),
          onTap: () => Navigator.of(context).pop(),
        ),
        //settings tile
        ListTile(
          leading: const Icon(Icons.settings),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsScreen()));
          },
          title: const Text("SETTINGS"),
        ),
      ]),
    );
  }
}
