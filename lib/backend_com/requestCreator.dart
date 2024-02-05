class RequestCreator {
  static List<Relation> relations = [];

  bool assertRelation(Relation rel) {
    bool found = false;
    relations.forEach((element) {
      if (((element.c1 == rel.c1 && element.c2 == rel.c2) ||
              (element.c1 == rel.c2 && element.c2 == rel.c1)) &&
          element.type == rel.type) {
        found = true;
      }
    });
    return found;
  }
}

class Relation {
  Class c1;
  Class c2;
  RelationType type;
  Relation(this.c1, this.c2, this.type);
}

enum Class { m1, m2 }

enum RelationType { oneToMany, onToOne, manyToMany }
