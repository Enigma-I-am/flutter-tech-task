import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/core/providers.dart';
import 'package:tech_task/presentation/views/recipe_page.dart';
import 'package:tech_task/presentation/widgets/custom_border.dart';
import 'package:tech_task/presentation/widgets/ingredient_list_item.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final recipieList = ref.watch(
      recipeVMProvider.select(
        (value) => value.ingredients,
      ),
    );

    final hasSelectedIngredients = recipieList.any(
      (element) => element.selected,
    );

    final loader = ref.watch(
      loaderVmProvider.select(
        (value) => value.isLoading,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Refrigerator",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: loader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: recipieList.isEmpty
                        ? Center(
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    selectedDate = picked;
                                    ref.read(recipeVMProvider).loadIngredient();
                                  });
                                }
                              },
                              child: CustomBorder(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(DateFormat('MM/dd/yy')
                                    .format(selectedDate)),
                              ),
                            ),
                          )
                        : ListView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            children: [
                              ...recipieList.map(
                                (it) => IngredientListItem(
                                  ingredient: it,
                                ),
                              ),
                            ],
                          ),
                  ),
                  if (hasSelectedIngredients)
                    AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: recipieList.any((element) => element.selected)
                          ? 1.0
                          : 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RecipiePage()),
                          ),
                          child: const Center(
                            child: Text(
                              'Get Recipies',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}