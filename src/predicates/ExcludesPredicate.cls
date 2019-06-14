global with sharing class ExcludesPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    return new ExcludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new ExcludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Integer value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Excludes cannot be used with Integer');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Excludes cannot be used with Long');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Excludes cannot be used with Decimal');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Excludes cannot be used with Double');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Excludes cannot be used with Date');
    throw ex;
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    InvalidParameterValueException ex = new InvalidParameterValueException('NewInstance', String.valueOf(value));
    ex.setMessage('Excludes cannot be used with DateTime');
    throw ex;
  }

  private ExcludesPredicate() {}
  private ExcludesPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' EXCLUDES (' + this.value + ')';
  }
}
