global with sharing class ReturningClause {
  // See https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_sosl_returning.htm#topic-title

  private String clauseType = null;
  private List<String> clauseFields = new List<String>();
  private IPredicate clausePredicate = null;
  private OrderBy clauseOrdering = null;
  private Integer clauseLimit = null;
  private Integer clauseOffset = null;

  global static ReturningClause NewInstance(SObjectType returningType) {
    return NewInstance(returningType.getDescribe().getName());
  }
  global static ReturningClause NewInstance(String returningType) {
    return new ReturningClause(returningType);
  }
  private ReturningClause(String returningType) {
    this.clauseType = returningType;
  }

  global ReturningClause SelectField(String f) {
    this.clauseFields.add(f);
    return this;
  }

  global ReturningClause SelectFields(String[] f) {
    this.clauseFields.addAll(f);
    return this;
  }

  global ReturningClause Predicate(IPredicate p) {
    this.clausePredicate = p;
    return this;
  }

  global ReturningClause OrderBy(OrderBy o) {
    this.clauseOrdering = o;
    return this;
  }

  global ReturningClause SetLimit(Integer l) {
    this.clauseLimit = l;
    return this;
  }
  
  global ReturningClause SetOffset(Integer o) {
    this.clauseOffset = o;
    return this;
  }

  override global String toString() {
    String clause = clauseType;
    
    // if nothing else is specified we just return the clause
    if (clauseFields.size() == 0 
      && clausePredicate == null 
      && clauseOrdering == null
      && clauseLimit == null
      && clauseOffset == null) {
        return clause;
      }

    clause += '(';

    if (clauseFields.size() > 0) {
      Boolean isFirstField = true;
      for (String f : clauseFields) {
        if (!isFirstField) {
          clause += ',';
        }
        clause += f;
        isFirstField = false;
      }
    }

    if (clausePredicate != null) {
      clause += ' WHERE ' + String.valueOf(this.clausePredicate);
    }

    if (clauseOrdering != null) {
      clause += ' ORDER BY ' + String.valueOf(this.clauseOrdering);
    }

    if (clauseLimit != null) {
      clause += ' LIMIT ' + this.clauseLimit;
    }

    if (clauseOffset != null) {
      clause += ' OFFSET ' + this.clauseOffset;
    }

    // the docs specify you may only use a LIMIT when fields are specified
    // I'm torn on whether to do what the user *asks* and break things
    // vs do what the user presumably *wants* and not break things
    // as you can see I've gone for the latter by checking clauseFields.size()
    if (clauseFields.size() > 0 && clauseLimit != null) {
      clause += ' LIMIT ' + clauseLimit;
    }

    clause += ')';

    return clause;
  }
}