import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavigationIconView> _navigationIconViews;

  @override
  void initState() {
    super.initState();
    _navigationIconViews = [
      NavigationIconView(
        title: '微信',
        icon: IconData(
          0xe6cb,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe6db,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title: '通讯录',
        icon: IconData(
          0xe655,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe6c2,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title: '发现',
        icon: IconData(
          0xe612,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe6c6,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title: '我的',
        icon: IconData(
          0xe758,
          fontFamily: Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe67d,
          fontFamily: Constants.IconFontFamily,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      //map方法遍历集合中的元素,toList转换成新的数组
      items: _navigationIconViews
          .map((NavigationIconView view) => view.item)
          .toList(),
      //当前用户选中的
      currentIndex: 0,
      //固定底部图标位置和大小
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        print('用户切换成第$index个Tap');
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('高仿微信'),
//        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){print('点击了搜索按钮');},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){print('显示下拉列表');},
          ),
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}

class NavigationIconView {
  final String _title;
  final IconData _icon;
  final IconData _activeIcon;

  //底部导航bar条目
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, IconData icon, IconData activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        item = BottomNavigationBarItem(
          //底部icon的字体
          title: Text(title, style: TextStyle(
            fontSize: 14.0,
            color: Color(AppColors.TapIconNormal),
          ),),
          //默认底部icon颜色
          icon: Icon(icon, color: Color(AppColors.TapIconNormal),),
          //激活的底部icon颜色
          activeIcon: Icon(activeIcon, color: Color(AppColors.TaoIconActive),),
          backgroundColor: Colors.white,
        );
}
