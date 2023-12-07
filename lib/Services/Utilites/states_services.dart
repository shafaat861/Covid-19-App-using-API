import 'dart:convert';

import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/Utilites/app_url.dart';
import 'package:http/http.dart'as http;

class StatesServices{
  Future<WorldStatesModel> fetchWorldRecords ()async{
    final response= await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
 return WorldStatesModel.fromJson(json);
    }
    else{
        throw Exception('Error');
    }

  }
  Future<List<dynamic>> countriesList ()async{
    var data;
    final response= await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
       data=jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }

  }
}