import 'package:flutter/material.dart';
import 'package:notes_app/component/drawer_tile.dart';
import 'package:notes_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //header
          Container(
            //color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            margin: const EdgeInsets.only(bottom: 25),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Notes App',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //notes tile
          DrawerTile(
              title: 'Notes',
              leading: const Icon(Icons.home),
              ontap: () => Navigator.pop(context)),

          //settings title
          DrawerTile(
            title: 'Settings',
            leading: const Icon(Icons.settings),
            ontap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
