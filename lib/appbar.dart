import 'package:flutter/material.dart';
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: DrawerButton(
        color: Colors.white,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      centerTitle: true,
      forceMaterialTransparency: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}