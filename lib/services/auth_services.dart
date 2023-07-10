// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "Eliminado por seguridad";
  final String _firebaseToken = 'Eliminado por seguridad';

  final storage = new FlutterSecureStorage();

  String? token;
  String? email;
  

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    print('auth_service.dart:  $decodedResp');

    if (decodedResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    String? emailLoger = decodedResp['email'];
    print('Este es el decode Responde  $decodedResp  . Y este es el mail de decodeResp auth_services.dart $emailLoger');

    if (decodedResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedResp['idToken']);
      await storage.write(key: 'email', value: emailLoger ?? '');
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }
  
   Future<String> readEmail() async {
    return await storage.read(key: 'email') ?? '';
  }
    
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'email');
  } 
}


