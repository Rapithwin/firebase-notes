import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:firebase_notes/pages/add_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

class ListNotes extends StatefulWidget {
  const ListNotes({
    super.key,
    required this.controller,
    required this.theme,
    required this.notes,
  });

  final StoreController controller;
  final ThemeData theme;
  final List<NotesModel> notes;

  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.theme.colorScheme;
    final notes = widget.notes;

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Obx(
          () => Card(
            clipBehavior: Clip.antiAlias,
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

              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                  right: 15,
                ),
                width: Get.size.width,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notes[index].title ?? "",
                      style: widget.theme.textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      notes[index].content ?? "",
                      maxLines: 1,
                      style: widget.theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(
                              'MMMM d, yyyy',
                            ).format(notes[index].dateModified!),
                            maxLines: 1,
                            style: widget.theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),

                          Visibility(
                            visible: widget.controller.anyNotesSelected(),
                            child: Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                shape: const CircleBorder(),

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
        );
      },
    );
  }
}
