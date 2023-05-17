import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

class Thesaurus {
  final String word;
  static bool isStarred = false;
  final List<String> synonyms;
  final List<String> antonyms;

  Thesaurus({
    required this.word,
    required this.synonyms,
    required this.antonyms,
  });

  factory Thesaurus.fromJson(Map<String, dynamic> json) {
    
    return Thesaurus(
        word: json["word"],
        synonyms: (json['synonyms'] as List).cast<String>(),
        antonyms: (json['antonyms'] as List).cast<String>());
  }
}

Future<Thesaurus> fetchThesaurus(String word) async {
  final response = await http.get(
      Uri.parse(
          'https://thesaurus-by-api-ninjas.p.rapidapi.com/v1/thesaurus?word=$word'),
      headers: {
        'X-RapidAPI-Key': 'c0eee5d0c9mshb4b1c8c8b43a3ffp149fdbjsnbaae8d74196e',
        'X-RapidAPI-Host': 'thesaurus-by-api-ninjas.p.rapidapi.com'
      });
  print(response.body);

  if (response.statusCode == 200) {
    return Thesaurus.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Request Failed");
  }
}
