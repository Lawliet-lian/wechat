import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';
import 'package:flutter_wechat/model/conversation.dart';


//微信聊天绘话条目
class _ConversationItem extends StatelessWidget{
  const _ConversationItem({Key key, this.conversation})
  : assert(conversation != null),super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    //根据图片的获取方式初始化头像组件
    if(conversation.isAvatarFromNet()){
      avatar = Image.network(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    }

    Widget avatarContainer;
    if(conversation.unreadMsgCount > 0){
      //未读消息角标
      Widget unreadMsgCountText = Container(
        alignment: Alignment.center,
        width: Constants.unreadMsgNotifyDotSize,
        height: Constants.unreadMsgNotifyDotSize,
        decoration: BoxDecoration(
          color: Color(AppColors.NotifyDotBg),
          //设置一半可以变圆
          borderRadius: BorderRadius.circular(Constants.unreadMsgNotifyDotSize/2,),
        ),
        child: Text(conversation.unreadMsgCount.toString(),style: AppStyle.unreadMsgNotifyDotStyle,),
      );

      //将头像和未读消息作为一个整体
      avatarContainer = Stack(
        //设置stack超出后任然显示
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            child: unreadMsgCountText,
            right: -6.0,
            top: -6.0,
          ),
        ],
      );
    } else {
      avatarContainer = avatar;
    }

    //设置右侧时间和免打扰模式
    List<Widget> _rightArea = <Widget>[
      Text(conversation.updateAt,style: AppStyle.DesStyle,),
      //添加时间和免打扰按钮之间的间距
      SizedBox(height: 8.0,),
    ];

    //添加勿扰模式图标，有就显示，没有就显示透明
    if(conversation.isMute){
      _rightArea.add(
          Icon(
            IconData(
              0xe60f,
              fontFamily: Constants.IconFontFamily,
            ),
            color: Color(AppColors.ConversationMuteIcon),
            size: Constants.ConversationMuteSize,
          )
      );
    } else {
      _rightArea.add(
          Icon(
            IconData(
              0xe60f,
              fontFamily: Constants.IconFontFamily,
            ),
            //设置颜色透明
            color: Colors.transparent,
            size: Constants.ConversationMuteSize,
          )
      );
    }



    return Container(
      //微信分割线
      decoration: BoxDecoration(
          color: Color(AppColors.ConversationItemBg),
        border: Border(
          bottom:BorderSide(
            color: Color(AppColors.DividerColor),
            width: Constants.DividerWidth,
          )
        )
      ),
      padding: EdgeInsets.all(6.0),

      child: Row(
        //延主轴(横轴)对称
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //左边头像
          avatarContainer,
          //头像和title中间的空隙
          Container(width: 10.0,),
          //中间标题，需要延展
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(conversation.title,style: AppStyle.TitleStyle,),
                Text(conversation.des,style: AppStyle.DesStyle,),
              ],
            ),
          ),
          //右边时间和免打扰模式
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _rightArea,
            ),
          ),
        ],
      ),
    );
  }

}

//电脑已登录条目
class _DeviceInfoItem extends StatelessWidget{
  final Devices devices;
  const _DeviceInfoItem({Key key, this.devices: Devices.WIN}) : super(key: key);

  int get iconName{
    return devices == Devices.WIN ? 0xebb1 : 0xe60e;
  }

  String get devicesName{
    return devices == Devices.WIN ? 'Windows' : 'Mac';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.DeviceInfoItemBg),
        border: Border(
          bottom: BorderSide(
            width: Constants.DividerWidth,
            color: Color(AppColors.DividerColor),
          )
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 20.0,),
          Icon(IconData(
            this.iconName,
            fontFamily: Constants.IconFontFamily,
          ),color: Color(AppColors.DeviceInfoItemIcon),size: 24.0,),
          SizedBox(width: 20.0,),
          Text('微信已在$devicesName端登录，手机通知关闭',style: TextStyle(color: Color(AppColors.DeviceInfoItemText)),),
        ],
      ),
    );
  }

}

class ConversationPage extends StatefulWidget{
  @override
  _ConversationPageState createState() {
    return _ConversationPageState();
  }

}

class _ConversationPageState extends State<ConversationPage>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //设置ListView的长度为mockConversations数组的长度
      itemCount: mockConversations.length,
      //ListView的index会回调回来，会回调mockConversations.length次
      itemBuilder: (BuildContext context, int index){
        if(index == 0){
          return _DeviceInfoItem(devices: Devices.MAC,);
        }
        return _ConversationItem(conversation: mockConversations[index],);
      },

    );
  }

}