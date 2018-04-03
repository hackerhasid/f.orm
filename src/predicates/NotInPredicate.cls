global with sharing class NotInPredicate extends BasicPredicate {
  private IQuery innerQuery = null;
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, List<Integer> value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, List<Long> value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, List<Decimal> value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, List<Double> value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, List<Date> value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, List<DateTime> value) {
    return new NotInPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, IQuery value) {
    return new NotInPredicate(fieldName, value);
  }

  private NotInPredicate(){}
  private NotInPredicate(String fieldName, String value) {
    super(fieldName, value);
  }
  private NotInPredicate(String fieldName, IQuery value) {
    super(fieldName, null);
    innerQuery = value;
  }

  override global String toString() {
    String innerValue = this.value;
    if (innerQuery != null) {
      innerValue = innerQuery.BuildQuery();
    }

    return this.field + ' NOT IN (' + innerValue + ')';
  }
}