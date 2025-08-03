import 'package:bloc_app/constants/colors.dart';
import 'package:bloc_app/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CharacterInfo(title: "status : ", value: character.status),
                    BuildDivider(endIndent: 250),
                    CharacterInfo(
                      title: "species : ",
                      value: character.species,
                    ),
                    BuildDivider(endIndent: 240),
                    CharacterInfo(title: "gender : ", value: character.gender),
                    BuildDivider(endIndent: 245),
                    CharacterInfo(
                      title: "origin : ",
                      value: character.origin!.name,
                    ),
                    BuildDivider(endIndent: 255),
                    CharacterInfo(
                      title: "location : ",
                      value: character.location.name,
                    ),
                    BuildDivider(endIndent: 235),
                    CharacterInfo(
                      title: "episodes : ",
                      value: character.episode
                          .map((url) => int.parse(url.split('/').last))
                          .toList()
                          .toString(),
                    ),
                    BuildDivider(endIndent: 230),
                    CharacterInfo(
                      title: 'created : ',
                      value: character.created.toString().substring(0, 10),
                    ),
                    BuildDivider(endIndent: 240),
                    const SizedBox(height: 390),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: character.id,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
        // centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: MyColors.white),
        ),
      ),
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class BuildDivider extends StatelessWidget {
  const BuildDivider({super.key, required this.endIndent});

  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: MyColors.yellow,
      endIndent: endIndent,
      height: 24,
      thickness: 2,
    );
  }
}
