import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class GridNotes extends StatelessWidget {
  const GridNotes({
    super.key,
    required this.mockNote,
    required this.theme,
  });

  final Map<String, String> mockNote;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,

      itemCount: mockNote.length,
      itemBuilder: (context, index) {
        return Card(
          color: theme.colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),

            child: Container(
              height: mockNote.values.toList()[index].length.toDouble() + 65,
              constraints: BoxConstraints(
                minHeight: Get.size.height / 14,
                maxHeight: Get.size.height / 6.5,
              ),

              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 12.0,
                  right: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      mockNote.keys.toList()[index],
                      style: theme.textTheme.titleLarge,
                    ),

                    Text(
                      mockNote.values.toList()[index],
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
