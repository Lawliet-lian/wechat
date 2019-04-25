import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';
import './conversation_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  List<Widget> _pages;
  List<NavigationIconView> _navigationIconViews;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //初始化底部icon和文字
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

    //页面控制器，初始化页面未当前选中的页面
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ConversationPage(),
      Container(color: Colors.blue,),
      Container(color: Colors.yellow,),
      Container(color: Colors.green,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //底部bar
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      //设置底部选中的颜色
      fixedColor: Color(AppColors.TabIconActive),
      //map方法遍历集合中的元素,toList转换成新的数组
      items: _navigationIconViews
          .map((NavigationIconView view) => view.item)
          .toList(),
      //当前用户选中的
      currentIndex: _currentIndex,
      //固定底部图标位置和大小
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        print('用户切换成第$index个Tap');
        setState(() {
          //设置当前页为点击的tap页
          _currentIndex = index;
          //点击tap后，跳转到对应的page页,动画时长200毫秒，动画曲线为预定义的
          _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('高仿微信'),
//        backgroundColor: Colors.black,
        //去除AppBar的阴影效果
        elevation: 0.0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            //搜索按钮
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('点击了搜索按钮');
              },
            ),
          ),
          PopupMenuButton(
            //右上角加号按钮
            icon: Icon(Icons.add),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ActionItem>>[
                //加号里的列表
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe6db, '发起群聊'),
                  //value对应的值为模板传进来的T值，也就是说每一个item在被点击的时候，
                  // 它的回调函数当中，就会把我们的模板参数回调回去
                  value: ActionItem.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe6e7, '添加朋友'),
                  value: ActionItem.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe650, '扫一扫'),
                  value: ActionItem.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe62e, '收付款'),
                  value: ActionItem.PAYMENT,
                ),
              ];
            },

            //PopupMenuButton的回调事件
            onSelected: (ActionItem selected) {
              print('点击的是$selected');
            },
          ),
          Container(width: 24.0),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index){
          print('当前打印的是第$index页');
          setState(() {
            //滑动页面时，将底部的tab页面换成page的页面，来完成联动
            _currentIndex = index;
          });
        },

      ),
      bottomNavigationBar: botNavBar,
    );
  }

  //提取公共方法，返回加号的每一行列表
  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        //设置icon的大小和颜色
        Icon(
          IconData(
            iconName,
            fontFamily: Constants.IconFontFamily,
          ),
          size: 22.0,
          color: Color(AppColors.AppBarPopupMenuColor),
        ),
        Container(
          width: 20.0,
        ),
        Text(
          title,
          style: TextStyle(color: Color(AppColors.AppBarPopupMenuColor)),
        ),
      ],
    );
  }
}

class NavigationIconView {
  //底部导航bar条目
  final BottomNavigationBarItem item;

  NavigationIconView(
      {Key key, String title, IconData icon, IconData activeIcon})
      : item = BottomNavigationBarItem(
          //底部icon的字体
          title: Text(title),
          //默认底部icon颜色
          icon: Icon(
            icon,
          ),
          //激活的底部icon颜色
          activeIcon: Icon(
            activeIcon,
          ),
          backgroundColor: Colors.white,
        );
}

enum ActionItem { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT }
