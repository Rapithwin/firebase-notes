import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

class AddEditPage extends StatefulWidget {
  final NotesModel? note;
  const AddEditPage({super.key, this.note});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  final StoreController storeController = Get.find<StoreController>();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title);
    _contentController = TextEditingController(text: widget.note?.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  bool _isEditing() => widget.note != null;

  void _onSave() async {
    final String title = _titleController.text;
    final String content = _contentController.text;
    late (bool success, String message) result;

    final NotesModel note = NotesModel(
      id: widget.note?.id,
      title: title,
      content: content,
      dateModified: DateTime.now(),
    );

    if (title.isEmpty && content.isEmpty) return;

    if (_isEditing()) {
      result = await storeController.updateNote(note);
    } else {
      result = await storeController.createNote(note);
    }

    if (mounted) {
      Get.snackbar(
        result.$1 ? "Success" : "Error",
        result.$2,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: result.$1
            ? Get.theme.colorScheme.inverseSurface
            : Get.theme.colorScheme.error,
        colorText: result.$1
            ? Get.theme.colorScheme.onInverseSurface
            : Get.theme.colorScheme.onError,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        themeController: themeController,
        title: Text(""),
        titleSpacing: 0,
        actions: [
          Obx(
            () => storeController.isLoading.value
                ? SizedBox(
                    height: 20,
                    width: 20,

                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  )
                : GestureDetector(
                    onTap: _onSave,
                    child: const Icon(Icons.check),
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26.0, right: 26.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 13,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 30,
                  color: theme.colorScheme.onSurface,
                ),
                minLines: 1,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration.collapsed(
                  hintText: "Title",

                  hintStyle: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 30,
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              Text(
                DateFormat(
                  'MMMM d, yyyy, h:mm a',
                ).format(widget.note?.dateModified ?? DateTime.now()),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SingleChildScrollView(
                child: TextField(
                  controller: _contentController,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: theme.colorScheme.onSurface,
                  ),
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: "Start typing...",

                    hintStyle: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
