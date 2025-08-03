import 'package:rick_and_morty/business_logic/characters_cubit.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/data/repositories/characters_repository.dart';
import 'package:rick_and_morty/data/web_services/characters_web_services.dart';
import 'package:rick_and_morty/presentation/screens/character_details.dart';
import 'package:rick_and_morty/presentation/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharacterScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(charactersRepository),
            child: CharacterDetails(character: character),
          ),
        );
    }
    return null;
  }
}
