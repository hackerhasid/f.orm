global with sharing class SimpleSOSLQuery implements IQuery {
  // https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_sosl_syntax.htm

  global Enum SearchGroup { ALL_FIELDS, NAME_FIELDS, EMAIL_FIELDS, PHONE_FIELDS, SIDEBAR_FIELDS }

  private String queryString = null;
  private SimpleSOSLQuery.SearchGroup querySearchGroup = null;
  private List<ReturningClause> queryReturningClause = new List<ReturningClause>();
  private Integer queryLimit = null;

  global static SimpleSOSLQuery NewInstance(String query) {
    return new SimpleSOSLQuery(query);
  }

  private SimpleSOSLQuery(String query) {
    this.queryString = query;
  }

  global SimpleSOSLQuery SetLimit(Integer l) {
    this.queryLimit = l;
    return this;
  }

  global SimpleSOSLQuery AndReturning(ReturningClause c) {
    queryReturningClause.add(c);
    return this;
  }

  global SimpleSOSLQuery OnlyReturning(ReturningClause c) {
    queryReturningClause.clear();
    queryReturningClause.add(c);
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
    String query = 'FIND {' + queryString + '}';

    if (querySearchGroup != null) {
      query += ' IN ';
      if (querySearchGroup == SimpleSOSLQuery.SearchGroup.ALL_FIELDS) {
        query += 'ALL FIELDS';
      } else if (querySearchGroup == SimpleSOSLQuery.SearchGroup.NAME_FIELDS) {
        query += 'NAME FIELDS';
      } else if (querySearchGroup == SimpleSOSLQuery.SearchGroup.EMAIL_FIELDS) {
        query += 'EMAIL FIELDS';
      } else if (querySearchGroup == SimpleSOSLQuery.SearchGroup.PHONE_FIELDS) {
        query += 'PHONE FIELDS';
      } else if (querySearchGroup == SimpleSOSLQuery.SearchGroup.SIDEBAR_FIELDS) {
        query += 'SIDEBAR FIELDS';
      }
    }

    if (queryReturningClause.size() > 0) {
      query += ' RETURNING ';
      Boolean isFirstClause = true;
      for (ReturningClause c : queryReturningClause) {
        if (!isFirstClause) {
          query += ',';
        }
        query += String.valueOf(c);
        isFirstClause = false;
      }
    }

    if (this.queryLimit != null) {
      query += ' LIMIT ' + this.queryLimit;
    }

    return query;
  }
}
