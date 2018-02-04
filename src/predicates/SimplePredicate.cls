global with sharing class SimplePredicate implements IPredicate {
  private String fieldName;
  private IOperator op;
  private String value;

  global SimplePredicate(String fieldName, IOperator op, String value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = '\'' + value + '\'';
  }

  global SimplePredicate(String fieldName, IOperator op, String[] value) {
    this.fieldName = fieldName;
    this.op = op;

    List<String> escaped = new List<String>();
    for (String s : value) {
      escaped.add('\'' + s + '\'');
    } 
    this.value = String.valueOf(String.join(escaped, ','));
  }

  global SimplePredicate(String fieldName, IOperator op, Integer value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = String.valueOf(value);
  }

  global SimplePredicate(String fieldName, IOperator op, Long value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = String.valueOf(value);
  }

  global SimplePredicate(String fieldName, IOperator op, Decimal value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = String.valueOf(value);
  }

  global SimplePredicate(String fieldName, IOperator op, Double value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = String.valueOf(value);
  }

  global SimplePredicate(String fieldName, IOperator op, Date value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = '\'' + DateTime.newInstance(value.year(), value.month(), value.day()).format('YYYY-MM-DD') + '\'';
  }

  global SimplePredicate(String fieldName, IOperator op, DateTime value) {
    this.fieldName = fieldName;
    this.op = op;
    this.value = '\'' + value.formatGMT('YYYY-MM-DDThh:mm:ssZ') + '\'';
  }

  override global String toString() {
    return this.op.toString(fieldName, value);
  }
}
