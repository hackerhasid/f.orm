global with sharing class GreaterThanPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, Integer value) {
    return new GreaterThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    return new GreaterThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    return new GreaterThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    return new GreaterThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    return new GreaterThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    return new GreaterThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }

  private GreaterThanPredicate() {}
  private GreaterThanPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' > ' + this.value;
  }
}
