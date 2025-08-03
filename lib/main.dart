import 'package:rick_and_morty/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RickAndMorty(appRouter: AppRouter()));
}

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
