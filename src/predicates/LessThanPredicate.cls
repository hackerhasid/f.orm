global with sharing class LessThanPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, Integer value) {
    return new LessThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    return new LessThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    return new LessThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    return new LessThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    return new LessThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    return new LessThanPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }

  private LessThanPredicate(){}
  private LessThanPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' < ' + this.value;
  }
}