import 'package:cctalk/mode/bean/base_bean.dart';

///
class UserBean extends BaseBean{
  String userId;
  String userName;
  String userPortrait;
  String token;
  int sentTime;

  UserBean(code,this.userId, this.userName, this.userPortrait, this.token,this.sentTime);

  UserBean.fromJson(dynamic obj){
    this.userId = obj["userId"];
    this.userName = obj["userName"];
    this.userPortrait = obj["userPortrait"];
    this.token = obj["token"];
    this.sentTime = obj["sentTime"];
  }

}