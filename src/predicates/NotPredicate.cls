global with sharing class NotPredicate implements IPredicate {
  private IPredicate predicate = null;
  global static IPredicate NewInstance(IPredicate predicate) {
    return new NotPredicate(predicate);
  }

  private NotPredicate(IPredicate predicate) {
    this.predicate = predicate;
  }

  override global String toString() {
    return 'NOT (' + String.valueOf(predicate) + ')';
  }
}