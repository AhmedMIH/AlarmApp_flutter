import 'package:clock_app/model/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget cutomeMenuButton(MenuInfo currentMenuInfo) {
  return Consumer<MenuInfo>(
    builder: (context, value, child) => TextButton(
      style: TextButton.styleFrom(
        backgroundColor: currentMenuInfo.menuType == value.menuType
            ? Color(0xFF444974)
            : Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
          ),
        ),
      ),
      onPressed: () {
        var menuInfo = Provider.of<MenuInfo>(context, listen: false);
        menuInfo.updateMenuInfo(currentMenuInfo);
      },
      child: Column(
        children: [
          Image.asset(
            currentMenuInfo.imageSource,
            scale: 1.5,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            currentMenuInfo.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
