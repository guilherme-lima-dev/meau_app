import 'dart:convert';

import 'package:meau/http_clients/dio_client.dart';
import 'package:meau/info/endpoints.dart';
import 'package:meau/interfaces/http_client_interface.dart';

class AuthService{
  final IHttpClient client;

  AuthService(this.client);

  Future<String?> auth(Map login) async{
    try{
      final body = await client.post(Endpoints.urlAuth, login);
      return body['idToken'];
    }catch(e){
      return null;
    }
  }

  Future<dynamic> register(Map register) async{
    try{
      final body = await client.post(Endpoints.urlRegister, json.encode(register));
      return body;
    }catch(e){
      return null;
    }
  }
}