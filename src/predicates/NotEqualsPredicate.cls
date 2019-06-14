global with sharing class NotEqualsPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Integer value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    return new NotEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }

  private NotEqualsPredicate(){}
  private NotEqualsPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' != ' + this.value;
  }
}