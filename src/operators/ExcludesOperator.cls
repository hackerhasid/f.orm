global with sharing class ExcludesOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' EXCLUDES ' + value;
  }
}
