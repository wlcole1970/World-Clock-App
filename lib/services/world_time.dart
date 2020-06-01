//import 'dart:math';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for UI
  String time; //time in location
  String flag; //URL to flag icon asset
  String url; //location URL for API endpoints
  bool isDaytime;  //true or false if day or not

  WorldTime({ this.location, this.flag, this.url});


  Future<void> getTime() async {
    try {
// make the request

      Response response = await get(
          'https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      //    print(datetime);
      //    print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));


      //set time property
      isDaytime = now.hour > 5 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch (e) {
      print('caught error: $e');
      time = 'could not get time data.';
    }
  }

}