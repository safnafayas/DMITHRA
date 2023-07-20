import 'package:shared_preferences/shared_preferences.dart';

void saveData(String loginid) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString('lgid', loginid);
}

Future<String?> getSavedData() async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  String? lgid= prefs.getString('lgid');
  return lgid;
}
void saveReq(String req_id) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString('rqid', req_id);
}
Future<String?> getReq() async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  String? rqid= prefs.getString('rqid');
  return rqid;
}
void saveData2(String recipientid) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString('apid', recipientid);
}

Future<String?> getSavedData2() async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  String? apid= prefs.getString('apid');
  return apid;
}