global with sharing class GreaterThanOrEqualsPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('GreaterThanOrEquals cannot be used with String');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('GreaterThanOrEquals cannot be used with String Array');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Integer value) {
    return new GreaterThanOrEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    return new GreaterThanOrEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    return new GreaterThanOrEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    return new GreaterThanOrEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    return new GreaterThanOrEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    return new GreaterThanOrEqualsPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }

  private GreaterThanOrEqualsPredicate() {}
  private GreaterThanOrEqualsPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' >= ' + this.value;
  }
}
