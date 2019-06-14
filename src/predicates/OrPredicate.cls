global with sharing class OrPredicate implements IPredicate {
  private List<IPredicate> predicates = new List<IPredicate>();
  global static OrPredicate NewInstance() {
    return new OrPredicate();
  }
  global static OrPredicate NewInstance(IPredicate p1, IPredicate p2) {
    OrPredicate p = OrPredicate.NewInstance();
    p.Append(p1);
    p.Append(p2);
    return p;
  }
  global static OrPredicate NewInstance(IPredicate p1, IPredicate p2, IPredicate p3) {
    OrPredicate p = OrPredicate.NewInstance(p1, p2);
    p.Append(p3);
    return p;
  }
  global static OrPredicate NewInstance(IPredicate p1, IPredicate p2, IPredicate p3, IPredicate p4) {
    OrPredicate p = OrPredicate.NewInstance(p1, p2, p3);
    p.Append(p4);
    return p;
  }
  global static OrPredicate NewInstance(IPredicate p1, IPredicate p2, IPredicate p3, IPredicate p4, IPredicate p5) {
    OrPredicate p = OrPredicate.NewInstance(p1, p2, p3, p4);
    p.Append(p5);
    return p;
  }
  global static OrPredicate NewInstance(IPredicate[] ps) {
    OrPredicate pred = OrPredicate.NewInstance();
    for (IPredicate p : ps) {
      pred.Append(p);
    }
    return pred;
  }

  global OrPredicate Append(IPredicate p) {
    predicates.add(p);
    return this;
  }
  
  override global String toString() {
    return '(' + String.join(predicates, ' OR ') + ')';
  }
}