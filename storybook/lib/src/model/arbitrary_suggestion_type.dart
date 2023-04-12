class ArbitrarySuggestionType implements Comparable<ArbitrarySuggestionType> {
  num stars;
  String name, imgURL;

  ArbitrarySuggestionType(this.stars, this.name, this.imgURL);

  @override
  int compareTo(ArbitrarySuggestionType other) {
    return stars == other.stars
        ? 0
        : stars > other.stars
            ? -1
            : 1;
  }
}
