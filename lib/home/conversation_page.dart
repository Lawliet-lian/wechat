import 'package:flutter/material.dart';
import 'package:flutter_wechat/constants.dart';
import 'package:flutter_wechat/model/conversation.dart';

//微信聊天绘话条目
class _ConcersationItem extends StatelessWidget{
  const _ConcersationItem({Key key, this.conversation})
  : assert(conversation != null),super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.all(4.0),

      child: Row(
        //延主轴(横轴)对称
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //左边头像
          Image.asset(
            'assets/images/ic_file_transfer.png',
            width: Constants.ConversationAvatarSize,
            height: Constants.ConversationAvatarSize,
          ),
          //头像和tetie中间的空隙
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(conversation.updateAt,style: AppStyle.DesStyle,),
//                Image.asset('assets/images/ic_fengchao.png'),
              ],
            ),
          ),
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
        itemBuilder: (BuildContext context, int index){
          return _ConcersationItem(conversation: mockConversations[index],);
        },
        itemCount: mockConversations.length,
    );
  }

}