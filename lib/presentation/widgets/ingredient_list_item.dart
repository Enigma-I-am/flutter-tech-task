import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/core/core.dart';
import 'package:tech_task/presentation/widgets/custom_border.dart';

class IngredientListItem extends HookConsumerWidget {
  const IngredientListItem({super.key, required this.ingredient});
  final IngredientModel ingredient;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(recipeVMProvider).toggle(ingredient),
      child: CustomBorder(
        backgroundColor:
            ingredient.selected ? Colors.green.withOpacity(0.2) : null,
        child: Row(
          children: [
            Text(ingredient.title),
          ],
        ),
      ),
    );
  }
}