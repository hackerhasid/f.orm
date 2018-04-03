global with sharing class ExcludesPredicate extends BasicPredicate {
  global static IPredicate NewInstance(String fieldName, String value) {
    return new ExcludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new ExcludesPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  
  private ExcludesPredicate() {}
  private ExcludesPredicate(String fieldName, String value) {
    super(fieldName, value);
  }

  override global String toString() {
    return this.field + ' EXCLUDES (' + this.value + ')';
  }
}
