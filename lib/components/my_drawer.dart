import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.music_note,
              size: 70,
            ),
          ),

          //
          const SizedBox(
            height: 25,
          ),

          //notes tile
          DrawerTile(
            title: "H O M E",
            leading: Icon(Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary),
            onTap: () {
              //pop
              Navigator.pop(context);

              //
            },
          ),

          //settings tile
          DrawerTile(
            title: "S E T T I N G S",
            leading: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary),
            onTap: () {
              //pop
              Navigator.pop(context);
              //
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SettingsPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key, required this.title, required this.leading, this.onTap});
  final String title;
  final Widget leading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                // fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
          leading: leading,
        ),
      ),
    );
  }
}
