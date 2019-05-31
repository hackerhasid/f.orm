global with sharing class AndPredicate implements IPredicate {
  private List<IPredicate> predicates = new List<IPredicate>();

  global static AndPredicate NewInstance() {
    return new AndPredicate();
  }

  global static AndPredicate NewInstance(IPredicate p1, IPredicate p2) {
    AndPredicate p = AndPredicate.NewInstance();
    p.Append(p1);
    p.Append(p2);
    return p;
  }
  global static AndPredicate NewInstance(IPredicate[] ps) {
    AndPredicate pred = AndPredicate.NewInstance();
    for (IPredicate p : ps) {
      pred.Append(p);
    }
    return pred;
  }

  global AndPredicate Append(IPredicate p) {
    predicates.add(p);
    return this;
  }
  
  override global String toString() {
    // HACK: unfortunately just calling String.join(predicates) doesn't seem to call the toString method :-(
    List<String> sPredicates = new List<String>();
    for (IPredicate p : predicates) {
      sPredicates.add(String.valueOf(p));
    }
    return '(' + String.join(sPredicates, ' AND ') + ')';
  }
}
