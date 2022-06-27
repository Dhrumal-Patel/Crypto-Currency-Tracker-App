import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

 static Future<bool> saveTheme(String theme) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool result = await pref.setString("theme",theme);
    return result;
  }

  static Future<String?> getTheme() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? currentTheme = pref.getString("theme");
    return currentTheme;
  }

  static Future<bool> addFavourite(String id) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    List<String> favourites = pref.getStringList("favourite") ?? [];
    favourites.add(id);

    return await pref.setStringList("favourite", favourites);
  }

  static Future<bool> removeFavourite(String id) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    
    List<String> favourites = pref.getStringList("favourite") ?? [];
    favourites.remove(id);

    return await pref.setStringList("favourite", favourites);
  }

  static Future<List<String>> fetchFavourites() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList("favourite") ?? [];
  }
}