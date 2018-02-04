global with sharing class SimpleSOQLQuery {
  private Set<String> queryFields = new Set<String>();
  private IPredicate predicate = null;
  private Integer queryLimit = null;
  private SObjectType queryObject;

  global SimpleSOQLQuery(SObjectType typeToQuery) {
    this.queryObject = typeToQuery;
  }

  global SimpleSOQLQuery AddSelect(String f) {
    queryFields.add(f);
    return this;
  }

  global SimpleSOQLQuery Predicate(IPredicate p) {
    predicate = p;
    return this;
  }

  global SimpleSOQLQuery SetLimit(Integer l) {
    this.queryLimit = l;
    return this;
  }

  global SObject First() {
    Integer oldLimit = this.queryLimit;
    this.queryLimit = 1;
    String query = buildQuery();
    SObject obj = Database.Query(query);
    this.queryLimit = oldLimit;
    return obj;
  }

  global SObject[] Execute() {
    String query = buildQuery();

    
    // query += ' '

    SObject[] objs = Database.Query(query);
    return objs;
  }

  private String buildQuery() {
    List<String> fields = new List<String>(this.queryFields);
    if (queryFields.size() == 0) {
      fields = new List<String>(getAllFieldNames(queryObject));
    }

    String query = 'SELECT ' + String.join(new List<String>(fields), ',');

    query += ' FROM ' + queryObject.getDescribe().getName();

    if (this.predicate != null) {
      query += ' WHERE ' + String.valueOf(this.predicate);
    }

    if (this.queryLimit != null) {
      query += ' LIMIT ' + this.queryLimit;
    }

    return query;
  }

  private Set<String> getAllFieldNames(SObjectType t) {
    Schema.DescribeSObjectResult describe = t.getDescribe();
    Map<String, Schema.SObjectField> fieldMap = describe.fields.getMap();
    Set<String> setWithFields = new Set<String>();

    for (Schema.SObjectField field : fieldMap.values()) {
      setWithFields.add(field.getDescribe().getLocalName());
    }

		return setWithFields;
	}
}
