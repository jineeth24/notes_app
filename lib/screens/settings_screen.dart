import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,borderRadius: BorderRadius.circular(10)),
              
              padding:const EdgeInsets.symmetric(vertical:20,horizontal: 20),
              margin:const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    const  Text("DarkMode",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              CupertinoSwitch(
                  value:   context.read<ThemeProvider>().isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeProvider>().toggleTheme();
                  }),
                    ],
                  ),
            ),
          )),
    );
  }
}
