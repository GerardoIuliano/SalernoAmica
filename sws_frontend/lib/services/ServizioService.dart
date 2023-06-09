import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

import '../util/QueryStringUtil.dart';
import 'RestURL.dart';
import 'UserService.dart';
import 'dto/ListResponse.dart';
import 'dto/LoginDTO.dart';
import 'dto/PuntoMappaDTO.dart';
import 'dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';
import 'package:frontend_sws/util/JwtUtil.dart';

import 'entity/Servizio.dart';

class ServizioService {
  final log = Logger('ServizioServiceLogger');
  UserService userService = UserService();

  Future<List<Servizio>?> serviziList(String? nome, String? idEnte,
      String? idArea, String? stato, int page, bool logged, String? orderString) async {
    String? token;
    if (logged) {
      token = await userService.getUser();
    }
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();

      queryStringUtil.addString("page=$page");
      if (nome != null) {
        queryStringUtil.add("name", nome);
      }
      if (idEnte != null) {
        queryStringUtil.add("idEnte", idEnte);
      }
      if (idArea != null) {
        queryStringUtil.add("idArea", idArea);
      }
      if (stato != null) {
        queryStringUtil.add("stato", stato);
      }
      if (orderString != null) {
        queryStringUtil.addString(orderString);
      }

      Uri u = Uri.parse(
          "${RestURL.servizioService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u,
          headers: token != null
              ? RestURL.authHeader(token!)
              : RestURL.defaultHeader);
      if (response.statusCode == 200) {
        ListResponse<Servizio> l = ListResponse<Servizio>.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)), Servizio.fromJson);
        return l.content;
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Servizio?> getServizio(String id) async {
    try {
      var response = await http.get(Uri.parse("${RestURL.servizioService}/$id"),
          headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<bool> deleteServizio(String id) async {
    String? token = await userService.getUser();
    try {
      var response = await http.delete(
          Uri.parse("${RestURL.servizioService}/$id"),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log.severe(e);
    }
    return false;
  }

  Future<Servizio?> editServizio(Servizio servizio) async {
    String? token = await userService.getUser();
    try {
      var response = await http.put(
          Uri.parse("${RestURL.servizioService}/${servizio.id}"),
          body: servizioToJson(servizio),
          headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Servizio?> createServizio(Servizio servizio) async {
    String? token = await userService.getUser();
    try {
      var response = await http.post(Uri.parse(RestURL.servizioService),
          body: servizioToJson(servizio), headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<List<PuntoMappaDto>?> findPuntiMappa(
      String? nome, String? idEnte, String? idArea) async {
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();
      queryStringUtil.add("punti", "true");

      if (nome != null) {
        queryStringUtil.add("name", nome);
      }
      if (idEnte != null) {
        queryStringUtil.add("idEnte", idEnte);
      }
      if (idArea != null) {
        queryStringUtil.add("idArea", idArea);
      }
      Uri u = Uri.parse(
          "${RestURL.servizioService}?${queryStringUtil.getQueryString()}");
      var response = await http.get(u, headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        var l = json.decode(utf8.decode(response.bodyBytes));
        return List<PuntoMappaDto>.from(
            l.map((model) => PuntoMappaDto.fromJson(model)));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Servizio?> editStatoServizio(
      String id, String stato, String? note) async {
    String? token = await userService.getUser();
    try {
      QueryStringUtil queryStringUtil = QueryStringUtil();

      queryStringUtil.add("stato", stato);
      if (note != null) {
        queryStringUtil.add("note", note);
      }
      Uri u = Uri.parse(
          "${RestURL.editStatoServizioService}/$id?${queryStringUtil.getQueryString()}");

      var response = await http.put(u, headers: RestURL.authHeader(token!));

      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<Servizio?> createDefibrillatore(Servizio servizio) async {
    Response? response;
    try {
      response = (await http.post(Uri.parse(RestURL.defibrillatoriService),
          body: servizioToJson(servizio), headers: RestURL.defaultHeader));
    } catch (e) {
      log.severe(e);
    }
    if (response != null) {
      if (response.statusCode == 200) {
        return servizioFromJson(utf8.decode(response.bodyBytes));
      } else if (response.statusCode == 405) {
        throw Exception(
            "L'ultimo defibrillatore inserito è ancora in validazione");
      }
    }
    return null;
  }

  Future<List<Servizio>?> serviziListByStruttura(String idStruttura) async {
    try {
      Uri u = Uri.parse("${RestURL.servizioStrutturaService}/$idStruttura");
      var response = await http.get(u, headers: RestURL.defaultHeader);
      if (response.statusCode == 200) {
        var l = json.decode(utf8.decode(response.bodyBytes));
        return List<Servizio>.from(
            l.map((model) => Servizio.fromJson(model)));
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }
}
