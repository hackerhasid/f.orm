global with sharing class InPredicate extends BasicPredicate {
  private IQuery innerQuery = null;
  global static IPredicate NewInstance(String fieldName, String value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, String[] value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Integer value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Long value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Decimal value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Double value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, Date value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, DateTime value) {
    return new InPredicate(fieldName, PredicateHelper.ToSoqlQueryString(value));
  }
  global static IPredicate NewInstance(String fieldName, IQuery value) {
    return new InPredicate(fieldName, value);
  }

  private InPredicate() {}
  private InPredicate(String fieldName, String value) {
    super(fieldName, value);
  }
  private InPredicate(String fieldName, IQuery value) {
    super(fieldName, null);
    innerQuery = value;
  }

  override global String toString() {
    String innerValue = this.value;
    if (innerQuery != null) {
      innerValue = innerQuery.BuildQuery();
    }

    return this.field + ' IN (' + innerValue + ')';
  }
}
