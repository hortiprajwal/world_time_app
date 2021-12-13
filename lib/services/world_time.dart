// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class WorldTime {

  String location; //location name for the UI
  String time = ""; //the time in that location
  String flag; //url to asset flag icon
  String url; //location url for api endpoint
  bool isDaytime = true; //true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    //http://worldtimeapi.org/api/timezone/Asia/Kolkata
    //https://jsonplaceholder.typicode.com/todos/1

    try {
      Response response  = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime =  now.hour > 6 && now.hour < 20 ?  true : false ;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }



  }

}


//instance.getTime();
