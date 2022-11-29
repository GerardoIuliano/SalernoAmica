import 'dart:convert';

import 'package:frontend_sws/services/entity/Contatto.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'RestURL.dart';
import 'UserService.dart';
import 'dto/ListResponse.dart';
import 'package:frontend_sws/util/QueryStringUtil.dart';
class ContattoService {
  final log = Logger('ContattoServiceLogger');
  UserService userService = UserService();

  Future<List<Contatto>?> contattoList(String? idEnte,int? page) async {
    try {
      QueryStringUtil queryStringUtil=QueryStringUtil();
      if (idEnte != null) {
        queryStringUtil.add("idEnte", idEnte);
      }
      if (page != null) {
        queryStringUtil.add("page", page.toString());
      } else {
        queryStringUtil.addString(RestURL.queryRemovePagination);
      }
      Uri u = Uri.parse("${RestURL.contattoService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u, headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        if (page != null) {
          ListResponse<Contatto> l = ListResponse<Contatto>.fromJson(
              jsonDecode(response.body), Contatto.fromJson);
          return l.content;
        } else {
          var l = json.decode(response.body);
          return List<Contatto>.from(l.map((model) => Contatto.fromJson(model)));
        }
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}
