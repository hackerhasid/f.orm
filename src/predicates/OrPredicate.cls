global with sharing class OrPredicate implements IPredicate{
  private List<IPredicate> predicates = new List<IPredicate>();
  global OrPredicate() {

  }
  global OrPredicate(IPredicate p1, IPredicate p2) {
    predicates.add(p1);
    predicates.add(p2);
  }
  global OrPredicate(IPredicate p1, IPredicate p2, IPredicate p3) {
    this(p1, p2);
    predicates.add(p3);
  }
  global OrPredicate(IPredicate p1, IPredicate p2, IPredicate p3, IPredicate p4) {
    this(p1, p2, p3);
    predicates.add(p4);
  }
  global OrPredicate(IPredicate p1, IPredicate p2, IPredicate p3, IPredicate p4, IPredicate p5) {
    this(p1, p2, p3, p4);
    predicates.add(p5);
  }
  global OrPredicate(IPredicate[] ps) {
    predicates.addAll(ps);
  }

  global OrPredicate Append(IPredicate p) {
    predicates.add(p);
    return this;
  }
  
  override global String toString() {
    return '(' + String.join(predicates, ' OR ') + ')';
  }
}