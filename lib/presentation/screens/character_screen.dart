import 'package:rick_and_morty/business_logic/characters_cubit.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  final _searchTextController = TextEditingController();
  List<Character> searchOfCharacters = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: MyColors.yellow,
        leading: _isSearching ? BackButton(color: MyColors.grey) : null,
        title: _isSearching ? _buildSearchField() : buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (connected) {
                return buildBlocWidget();
              } else {
                return buildNoInternetWidget();
              }
            },
        child: showLoadingIndicator(),
      ),
    );
  }

  //  buildBlocWidget(),

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        InkWell(
          child: IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear),
            color: MyColors.grey,
          ),
        ),
      ];
    } else {
      return [
        InkWell(
          child: IconButton(
            onPressed: _startSearch,
            icon: Icon(Icons.search, color: MyColors.grey),
          ),
        ),
      ];
    }
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchOfCharacters = allCharacters
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  void _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildAppBarTitle() {
    return const Text('Characters', style: TextStyle(color: MyColors.grey));
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.grey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.grey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.grey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: MyColors.yellow),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _isSearching
          ? searchOfCharacters.length
          : allCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: _isSearching
              ? searchOfCharacters[index]
              : allCharacters[index],
        );
      },
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Can't connect .. check your internet ",
              style: TextStyle(color: MyColors.grey, fontSize: 24),
            ),
            Image.asset('assets/images/no_internet.png'),
            // Icon(
            //   Icons.wifi_off,
            //   size: 100,
            //   color: Colors.grey,
            // ),
          ],
        ),
      ),
    );
  }
}
