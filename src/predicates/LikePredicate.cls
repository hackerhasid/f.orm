global with sharing class LikePredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    return new LikePredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new LikePredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }

  private LikePredicate(){}
  private LikePredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' LIKE ' + this.value;
  }
}