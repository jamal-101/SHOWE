import 'package:flutter/material.dart';
import '../model/single_proram_model.dart';
import '../utils/programme_colors.dart';
import 'block_previews.dart';
import 'block_reveal_widget.dart';
import 'reader_block_theme.dart';

class ReaderBlockWidget extends StatelessWidget {
  final Blocks block;
  final String? heroTag;
  final Data? programme;
  final Pages? page;

  const ReaderBlockWidget({
    super.key,
    required this.block,
    this.heroTag,
    this.programme,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    final layout = block.layout;
    final bgColor = resolveLayoutBackground(layout);
    final isHero = block.type == 'hero';

    // React uses layout padding as raw px (undefined → 0).
    final padTop = (layout?.paddingTop ?? 0).toDouble();
    final padBottom = (layout?.paddingBottom ?? 0).toDouble();
    final padX = isHero
        ? (layout?.paddingX ?? 0).toDouble()
        : (layout?.paddingX ?? 20).toDouble();

    return ReaderBlockTheme.fromLayout(
      layout,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: padTop,
          bottom: padBottom,
          left: padX,
          right: padX,
        ),
        color: bgColor,
        child: BlockRevealWidget(
          animation: block.animation,
          child: renderBlockPreview(
            block: block,
            heroTag: heroTag,
            programme: programme,
            page: page,
          ),
        ),
      ),
    );
  }
}
