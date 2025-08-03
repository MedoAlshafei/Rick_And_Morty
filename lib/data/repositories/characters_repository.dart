import 'package:bloc_app/data/models/character.dart';
import 'package:bloc_app/data/web_services/characters_web_services.dart';

class CharactersRepository {
  CharactersRepository(this.charactersWebServices);

  final CharactersWebServices charactersWebServices;

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
