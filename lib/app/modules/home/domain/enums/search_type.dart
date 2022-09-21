enum SearchType {
  comics,
  characters;

  static SearchType? fromName(String name) {
    for (final enumVariant in SearchType.values) {
      if (enumVariant.name == name) return enumVariant;
    }
    return null;
  }
}