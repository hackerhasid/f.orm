global with sharing class SimpleSOQLQuery implements IQuery {
  private Set<String> queryFields = new Set<String>();
  private IPredicate predicate = null;
  private Integer queryLimit = null;
  private Integer queryOffset = null;
  private OrderBy queryOrdering = null;
  private SObjectType queryObject = null;
  private String queryFor = null;

  global static SimpleSOQLQuery NewInstance(SObjectType typeToQuery) {
    return new SimpleSOQLQuery(typeToQuery);
  }

  private SimpleSOQLQuery(SObjectType typeToQuery) {
    this.queryObject = typeToQuery;
  }


  global SimpleSOQLQuery SelectField(String f) {
    queryFields.add(f);
    return this;
  }

  // global SimpleSOQLQuery Include(String assoc) {
  //   String relationshipName = '';
  //   List<String> fieldsToTraverse = assoc.split('\\.');
  //   Map<String, Schema.SObjectField> objectFields = queryObjectFields();

  //   while(fieldsToTraverse.size() > 0) {
  //     Boolean isChildmostField = false;
  //     String currentFieldName = fieldsToTraverse.remove(0);
  //     if (fieldsToTraverse.size() == 0) {
  //       isChildmostField = true;
  //     }
  //     // end users may use __r for their custom relationship not realizing
  //     // we expect __c since that's the actual field on the DescribeFieldResult
  //     // let's fix that for them
  //     if (currentFieldName.endsWith('__r')) {
  //       currentFieldName = currentFieldName.left(currentFieldName.length() - 1) + 'c';
  //     }

  //     Schema.DescribeFieldResult describeField = objectFields.get(currentFieldName).getDescribe();

  //     relationshipName += describeField.getRelationshipName() + '.';
  //     List<Schema.sObjectType> referencedObjects = describeField.getReferenceTo();

  //     // if we're on the last field then we need to grab all it's fields
  //     if (isChildmostField) {
  //       Set<String> fieldNames = new Set<String>();
  //       for (Schema.sObjectType objType : referencedObjects) {
  //         for(String fn : getAllFieldNames(objType)) {
  //           fieldNames.add(relationshipName + fn);
  //         }
  //       }
  //       // now append all these field names to the query
  //       queryFields.addAll(fieldNames);
  //     } else {
  //       // reset objectFields and put all elements from all possible related types
  //       objectFields = new Map<String, Schema.SObjectField>();
  //       for(Schema.sObjectType st : referencedObjects) {
  //         objectFields.putAll(st.getDescribe().fields.getMap());
  //       }
  //     }
  //   }

  //   return this;
  // }

  global SimpleSOQLQuery Predicate(IPredicate p) {
    predicate = p;
    return this;
  }

  global SimpleSOQLQuery OrderBy(OrderBy o) {
    this.queryOrdering = o;
    return this;
  }

  global SimpleSOQLQuery SetOffset(Integer o) {
    this.queryOffset = o;
    return this;
  }

  global SimpleSOQLQuery SetLimit(Integer l) {
    this.queryLimit = l;
    return this;
  }

  global SimpleSOQLQuery ForView() {
    this.queryFor = 'VIEW';
    return this;
  }

  global SimpleSOQLQuery ForReference() {
    this.queryFor = 'REFERENCE';
    return this;
  }

  global SimpleSOQLQuery ForUpdate() {
    this.queryFor = 'UPDATE';
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
    return Database.Query(query);
  }

  public String BuildQuery() {
    List<String> fields = new List<String>(this.queryFields);
    if (queryFields.size() == 0) {
      fields = new List<String>(getAllFieldNames(queryObject));
    }

    String query = 'SELECT ' + String.join(new List<String>(fields), ',');

    query += ' FROM ' + queryObject.getDescribe().getName();

    if (this.predicate != null) {
      query += ' WHERE ' + String.valueOf(this.predicate);
    }

    if (this.queryOrdering != null) {
      query += ' ORDER BY ' + String.valueOf(this.queryOrdering);
    }
    if (this.queryLimit != null) {
      query += ' LIMIT ' + this.queryLimit;
    }

    if (this.queryOffset != null) {
      query += ' OFFSET ' + this.queryOffset;
    }

    if (this.queryFor != null) {
      query += ' FOR ' + this.queryFor;
    }

    return query;
  }

  Map<String, Schema.SObjectField> queryObjectFields = null;
  private Map<String, Schema.SObjectField> queryObjectFields() {
    if (this.queryObjectFields == null) {
      Schema.DescribeSObjectResult describe = queryObject.getDescribe();
      this.queryObjectFields = describe.fields.getMap();
    }
    return this.queryObjectFields;
  }

  private Set<String> getAllFieldNames(SObjectType t) {
    Map<String, Schema.SObjectField> fieldMap = queryObjectFields();
    Set<String> setWithFields = new Set<String>();

    for (Schema.SObjectField field : fieldMap.values()) {
      setWithFields.add(field.getDescribe().getLocalName());
    }

		return setWithFields;
	}
}
