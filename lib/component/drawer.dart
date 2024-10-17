import 'package:flutter/material.dart';
import 'package:notes_app/component/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: Icon(Icons.note),
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
              ontap: () {})
        ],
      ),
    );
  }
}
