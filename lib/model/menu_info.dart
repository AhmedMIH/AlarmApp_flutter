import 'package:clock_app/model/menu_type.dart';
import 'package:flutter/foundation.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(this.menuType, {this.title, this.imageSource});

  updateMenuInfo(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.imageSource = menuInfo.imageSource;
    this.title = menuInfo.title;

    notifyListeners();
  }
}
