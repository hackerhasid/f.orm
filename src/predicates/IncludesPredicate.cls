global with sharing class IncludesPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    return new IncludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new IncludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }

  private IncludesPredicate() { }
  private IncludesPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' INCLUDES (' + this.value + ')';
  }
}
