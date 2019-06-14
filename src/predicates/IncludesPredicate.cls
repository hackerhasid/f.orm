global with sharing class IncludesPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    return new IncludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new IncludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Integer value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Includes cannot be used with Integer');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Includes cannot be used with Integer');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Includes cannot be used with Integer');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Includes cannot be used with Integer');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Includes cannot be used with Integer');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Includes cannot be used with Integer');
    throw ex;
  }

  private IncludesPredicate() { }
  private IncludesPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' INCLUDES (' + this.value + ')';
  }
}
