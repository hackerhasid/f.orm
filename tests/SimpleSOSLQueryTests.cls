@isTest
public class SimpleSOSLQueryTests {
  @isTest static void SimpleReturningTest() {
    SimpleSOSLQuery query = SimpleSOSLQuery.newInstance('Microsoft')
      .AndReturning(ReturningClause.newInstance(Account.getSObjectType()));

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} RETURNING Account', strQuery);
  }
}
