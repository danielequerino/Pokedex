class Pokemon {
  final int id;
  final String name;
  final List<String> type;
  final Map<String, int> baseStats; // Usando Map conforme solicitado

  // Construtor da classe
  const Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.baseStats,
  });

}
