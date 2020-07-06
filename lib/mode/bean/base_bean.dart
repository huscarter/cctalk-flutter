import 'package:cctalk/net/net_config.dart';

///
class BaseBean{
  ///
  int code = NetConfig.FAILED;

  BaseBean(){
    //
  }

  BaseBean.fromJson(dynamic map){
    this.code = map["code"];
  }
}