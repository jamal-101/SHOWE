class ProgrammeDoc {
  final String id;
  final String title;
  final List<ProgrammePage> pages;

  ProgrammeDoc({
    required this.id,
    required this.title,
    required this.pages,
  });
}

class ProgrammePage {
  final String id;
  final String title;
  final List<Block> blocks;

  ProgrammePage({
    required this.id,
    required this.title,
    required this.blocks,
  });
}

class BlockLayout {
  final String? background;
  final String? backgroundCustom;
  final double paddingTop;
  final double paddingBottom;
  final double paddingX;

  BlockLayout({
    this.background,
    this.backgroundCustom,
    this.paddingTop = 16,
    this.paddingBottom = 16,
    this.paddingX = 16,
  });
}

class Block {
  final String id;
  final String type;
  final BlockLayout layout;
  final Map<String, dynamic> data;

  Block({
    required this.id,
    required this.type,
    required this.layout,
    required this.data,
  });
}