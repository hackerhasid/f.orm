global with sharing class AndPredicate implements IPredicate, IComplexPredicate {
  private List<IPredicate> predicates = new List<IPredicate>();

  global AndPredicate() {

  }

  global AndPredicate(IPredicate p1, IPredicate p2) {
      predicates.add(p1);
      predicates.add(p2);
  }
  global AndPredicate(IPredicate p1, IPredicate p2, IPredicate p3) {
    this(p1, p2);
    predicates.add(p3);
  }
  global AndPredicate(IPredicate p1, IPredicate p2, IPredicate p3, IPredicate p4) {
    this(p1, p2, p3);
    predicates.add(p4);
  }
  global AndPredicate(IPredicate p1, IPredicate p2, IPredicate p3, IPredicate p4, IPredicate p5) {
    this(p1, p2, p3, p4);
    predicates.add(p5);
  }
  global AndPredicate(IPredicate[] ps) {
    predicates.addAll(ps);
  }

  global AndPredicate Append(IPredicate p) {
    predicates.add(p);
    return this;
  }
  
  override global String toString() {
    return '(' + String.join(predicates, ' AND ') + ')';
  }
}
