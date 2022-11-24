import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/services/dto/ListResponse.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';

class EnteService {
  final log = Logger('EnteServiceLogger');
  UserService userService = UserService();

  Future<List<Utente>?> enteList(
      String? name,int? page) async {
    try {
      List<String> queryArr=[];

      String query="";
      if(name!=null){
        queryArr.add("name=$name");
      }
      if(page!=null){
        queryArr.add("page=$page");
      }
      if(queryArr.isNotEmpty){
        query=queryArr.join("&");
      }
      Uri u=Uri.parse("${RestURL.enteService}?$query");
      var response = await http.get(
          u,
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        if(page!=null){
          ListResponse<Utente> l = ListResponse<Utente>.fromJson(
              jsonDecode(response.body), Utente.fromJson);
          return l.content;
        }
        else{
          Iterable l = json.decode(response.body);
          List<Utente> notPage = List<Utente>.from(l.map((model)=> Utente.fromJson(model)));
          return notPage;
        }

      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }


}