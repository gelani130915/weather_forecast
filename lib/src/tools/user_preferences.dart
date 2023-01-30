import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new UserPreferences();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class UserPreferences {

  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }  

  String get favorites {
    return _prefs.getString('favorites') ?? '[]';
  }

  set favorites(String value) {
     _prefs.setString('favorites', value);
  } 

}

