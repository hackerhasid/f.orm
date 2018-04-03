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
    // HACK: unfortunately just calling String.join(predicates) doesn't seem to call the toString method :-(
    List<String> sPredicates = new List<String>();
    for (IPredicate p : predicates) {
      sPredicates.add(String.valueOf(p));
    }

    return '(' + String.join(sPredicates, ' OR ') + ')';
  }
}