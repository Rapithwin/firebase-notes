import 'package:firebase_notes/controllers/style_controller.dart';
import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:firebase_notes/pages/home_page/home_page.dart';
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
  late TextEditingController _titleController, _contentController;
  late UndoHistoryController _contentUndoController;
  final StoreController storeController = Get.find<StoreController>();
  final ThemeController themeController = Get.find<ThemeController>();
  final StyleController styleController = Get.find<StyleController>();

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();

  bool _showUndoRedo = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title);
    _contentController = TextEditingController(text: widget.note?.content);
    _contentUndoController = UndoHistoryController();

    _titleFocusNode.addListener(_handleFocusChange);
    _contentFocusNode.addListener(_handleFocusChange);
    // Initial state
    _showUndoRedo = _contentFocusNode.hasFocus;
  }

  void _handleFocusChange() {
    setState(() {
      _showUndoRedo = _contentFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentUndoController.dispose();
    _titleFocusNode.removeListener(_handleFocusChange);
    _contentFocusNode.removeListener(_handleFocusChange);
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
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
    Get.offAll(() => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final double scale = styleController.scaleFactor;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: AppBar(
            title: const Text(""),
            titleSpacing: 0,
            actionsPadding: const EdgeInsets.only(right: 18.0),
            leadingWidth: 72,
            leading: const BackButton(),
            actions: [
              if (_showUndoRedo)
                ValueListenableBuilder(
                  valueListenable: _contentUndoController,
                  builder: (context, value, child) {
                    return Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            _contentUndoController.undo();
                          },
                          icon: Icon(
                            Icons.undo,
                            color: value.canUndo
                                ? Get.theme.colorScheme.onSurface
                                : Get.theme.colorScheme.onSurface.withAlpha(
                                    110,
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _contentUndoController.redo();
                          },
                          icon: Icon(
                            Icons.redo,
                            color: value.canRedo
                                ? Get.theme.colorScheme.onSurface
                                : Get.theme.colorScheme.onSurface.withAlpha(
                                    110,
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

              Obx(
                () => storeController.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.only(right: 18.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: _onSave,
                        icon: const Icon(Icons.check),
                      ),
              ),
            ],
          ),
        ),
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
                focusNode: _titleFocusNode,
                style: TextStyle(
                  fontSize: 30 * scale,
                  fontFamily: "Inter",
                  color: theme.colorScheme.onSurface,
                ),
                minLines: 1,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration.collapsed(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 30 * scale,
                    fontFamily: "Inter",
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              Text(
                DateFormat(
                  'MMMM d, yyyy, h:mm a',
                ).format(widget.note?.dateModified ?? DateTime.now()),
                style: TextStyle(
                  fontSize: 12.0 * scale,
                  fontFamily: "Inter",
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SingleChildScrollView(
                child: TextField(
                  undoController: _contentUndoController,
                  focusNode: _contentFocusNode,
                  controller: _contentController,
                  style: TextStyle(
                    fontSize: 18 * scale,
                    color: theme.colorScheme.onSurface,
                  ),
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: "Start typing...",
                    hintStyle: TextStyle(
                      fontSize: 18 * scale,
                      fontFamily: "Inter",
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
