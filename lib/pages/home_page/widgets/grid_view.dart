import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:firebase_notes/pages/add_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

class GridNotes extends StatefulWidget {
  const GridNotes({
    super.key,
    required this.controller,
    required this.theme,
  });

  final StoreController controller;
  final ThemeData theme;

  @override
  State<GridNotes> createState() => _GridNotesState();
}

class _GridNotesState extends State<GridNotes> {
  @override
  Widget build(BuildContext context) {
    final List<NotesModel> notes = widget.controller.notes;
    final colorScheme = widget.theme.colorScheme;

    return MasonryGridView.count(
      crossAxisCount: 2,

      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Obx(
          () => Card(
            color: widget.controller.isSelectedById(notes[index].id)
                ? colorScheme.secondaryContainer
                : colorScheme.surfaceContainerHighest,
            child: InkWell(
              splashFactory: InkSparkle.splashFactory,
              onTap: () {
                widget.controller.anyNotesSelected()
                    ? widget.controller.toggleSelected(index)
                    : Get.to(
                        () => AddEditPage(
                          note: notes[index],
                        ),
                        transition: Transition.zoom,
                      );
              },

              onLongPress: () {
                widget.controller.toggleSelected(index);
              },

              child: Flexible(
                child: Container(
                  height:
                      notes[index].content != null && notes[index].title != null
                      ? notes[index].content!.length.toDouble() + 120
                      : 200,
                  constraints: BoxConstraints(
                    minHeight: Get.size.height / 14,
                    maxHeight: Get.size.height / 4.5,
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      top: 12.0,
                      right: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notes[index].title ?? "",
                          style: widget.theme.textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          notes[index].content ?? "",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: widget.theme.textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  DateFormat(
                                    'MMMM d, yyyy',
                                  ).format(notes[index].dateModified!),
                                  maxLines: 2,
                                  style: widget.theme.textTheme.bodySmall
                                      ?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Visibility(
                                visible: widget.controller.anyNotesSelected(),
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    shape: CircleBorder(),

                                    value: widget.controller.isSelectedById(
                                      notes[index].id,
                                    ),
                                    onChanged: (_) {
                                      widget.controller.toggleSelected(index);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
