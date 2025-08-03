import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          characterDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          footer: Hero(
            tag: character.id,
            child: Container(
              color: Colors.black54,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.grey,
            child: character.image.isEmpty
                ? const CircularProgressIndicator(color: MyColors.yellow)
                : Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
          ),
        ),
      ),
    );
  }
}
