import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/core/core.dart';
import 'package:tech_task/presentation/widgets/custom_border.dart';

class RecipiePage extends StatefulHookConsumerWidget {
  const RecipiePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipiePageState();
}

class _RecipiePageState extends ConsumerState<RecipiePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recipeVMProvider).loadRecipies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipies = ref.watch(recipeVMProvider.select((it) => it.recipies));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            ref.read(recipeVMProvider).recipies = [];
            Navigator.pop(context);
          },
        ),
      ),
      body: recipies == null
          ? const Center(
              child: Text('failed to load recipies'),
            )
          : Column(
              children: [
                Flexible(
                  child: (recipies.isEmpty)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          children: [
                            ...recipies
                                .map(
                                  (e) => Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          e.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      ...e.ingredients
                                          .map(
                                            (e) => CustomBorder(
                                              child: Row(
                                                children: [
                                                  Text(e),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  ),
                                )
                                .toList()
                          ],
                        ),
                ),
              ],
            ),
    );
  }
}