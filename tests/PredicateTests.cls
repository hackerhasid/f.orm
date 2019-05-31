@isTest
public class PredicateTests {
  @isTest static void AndPredicate_PassedTwoPredicates() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1', TestPicklist__c = 'One');
    TestObject__c t2 = new TestObject__c(TestText__c = '1', TestPicklist__c = 'Two');
    insert t1;
    insert t2;

    Test.startTest();
   TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(AndPredicate.newInstance(
        EqualsPredicate.newInstance('TestText__c', '1'), 
        EqualsPredicate.newInstance('TestPicklist__c', 'Two'))
        )
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }


  @isTest static void AndPredicate_PassedList() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1', TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestText__c = '1', TestCurrency__c = 2);
    TestObject__c t3 = new TestObject__c(TestText__c = '1', TestCurrency__c = 3);
    TestObject__c t4 = new TestObject__c(TestText__c = '2', TestCurrency__c = 4);
    insert t1;
    insert t2;
    insert t3;
    insert t4;

    Test.startTest();
   TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(AndPredicate.newInstance(new List<IPredicate>{
        EqualsPredicate.newInstance('TestText__c', '1'), 
        GreaterThanPredicate.newInstance('TestCurrency__c', 1),
        GreaterThanPredicate.newInstance('TestCurrency__c', 2)
      }))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts.get(0).Id);
  }

  @isTest static void OrPredicate_PassedTwoPredicates() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1');
    TestObject__c t2 = new TestObject__c(TestText__c = '2');
    TestObject__c t3 = new TestObject__c(TestText__c = '3');
    insert t1;
    insert t2;
    insert t3;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(OrPredicate.newInstance(
        EqualsPredicate.newInstance('TestText__c', '1'),
        EqualsPredicate.newInstance('TestText__c', '3')))
      .OrderBy(OrderBy.FirstBy('TestText__c', OrderBy.OrderDirection.ASCENDING))
      .Execute();

    Test.stopTest();

    System.assertEquals(2, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
    System.assertEquals(t3.Id, ts.get(1).Id);
  }

  @isTest static void OrPredicate_PassedList() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1');
    TestObject__c t2 = new TestObject__c(TestText__c = '2');
    TestObject__c t3 = new TestObject__c(TestText__c = '3');
    TestObject__c t4 = new TestObject__c(TestText__c = '4');
    insert t1;
    insert t2;
    insert t3;
    insert t4;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(OrPredicate.newInstance(new List<IPredicate>{
        EqualsPredicate.newInstance('TestText__c', '1'),
        EqualsPredicate.newInstance('TestText__c', '2'),
        EqualsPredicate.newInstance('TestText__c', '4')
      }))
      .OrderBy(OrderBy.FirstBy('TestText__c', OrderBy.OrderDirection.ASCENDING))
      .Execute();

    Test.stopTest();

    System.assertEquals(3, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
    System.assertEquals(t2.Id, ts.get(1).Id);
    System.assertEquals(t4.Id, ts.get(2).Id);
  }

  // EQUALS
  @isTest static void Equals_String() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1');
    TestObject__c t2 = new TestObject__c(TestText__c = '2');
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestText__c', '2'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }
  @isTest static void Equals_Integer() {
    TestObject__c t1 = new TestObject__c(TestNumber__c = 1);
    TestObject__c t2 = new TestObject__c(TestNumber__c = 2);
    TestObject__c t3 = new TestObject__c(TestNumber__c = 3);
    insert t1;
    insert t2;
    insert t3;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestNumber__c', 3))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts[0].Id);
  }
  @isTest static void Equals_Long() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    TestObject__c t3 = new TestObject__c(TestCurrency__c = 3);
    insert t1;
    insert t2;
    insert t3;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestCurrency__c', (long)3.0))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts[0].Id);
  }
  @isTest static void Equals_Decimal() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    TestObject__c t3 = new TestObject__c(TestCurrency__c = 3);
    insert t1;
    insert t2;
    insert t3;
    
    Decimal d = 3;
    Test.startTest();

    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestCurrency__c', d))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts.get(0).Id);
  }
  @isTest static void Equals_Double() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    TestObject__c t3 = new TestObject__c(TestCurrency__c = 3);
    insert t1;
    insert t2;
    insert t3;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestCurrency__c', (double)3))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts[0].Id);
  }
  @isTest static void Equals_Date() {
    TestObject__c t1 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,1));
    TestObject__c t2 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,2));
    TestObject__c t3 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,3));
    insert t1;
    insert t2;
    insert t3;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestDate__c', Date.newInstance(2012,1,3)))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts[0].Id);
  }
  @isTest static void Equals_DateTime() {
    TestObject__c t1 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,1,3,0,0));
    TestObject__c t2 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,2,3,0,0));
    TestObject__c t3 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,3,3,0,0));
    insert t1;
    insert t2;
    insert t3;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(EqualsPredicate.newInstance('TestDateTime__c', DateTime.newInstance(2012,1,3,3,0,0)))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t3.Id, ts[0].Id);
  }

  // NOT EQUALS
  @isTest static void NotEquals_String() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1');
    TestObject__c t2 = new TestObject__c(TestText__c = '2');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestText__c', '2'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }
  @isTest static void NotEquals_Integer() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestCurrency__c', 2))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }
  @isTest static void NotEquals_Long() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestCurrency__c', (long)2.0))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }
  @isTest static void NotEquals_Decimal() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1.0);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2.0);
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestCurrency__c', (decimal)2.0))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }
  @isTest static void NotEquals_Double() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1.0);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2.0);
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestCurrency__c', (double)2))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }
  @isTest static void NotEquals_Date() {
    TestObject__c t1 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,1));
    TestObject__c t2 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,2));
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestDate__c', Date.newInstance(2012,1,2)))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }
  @isTest static void NotEquals_DateTime() {
    TestObject__c t1 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,1,3,0,0));
    TestObject__c t2 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,2,3,0,0));
    insert t1;
    insert t2;
    
    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotEqualsPredicate.newInstance('TestDateTime__c', DateTime.newInstance(2012,1,2,3,0,0)))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }

  // LIKE
  @isTest static void Like_String() {
    TestObject__c t1 = new TestObject__c(TestText__c = 'AAA');
    TestObject__c t2 = new TestObject__c(TestText__c = 'BBB');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(LikePredicate.newInstance('TestText__c', 'A%'))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts[0].Id);
  }

  // NOT
  @isTest static void SimpleNotLikeString() {
    TestObject__c t1 = new TestObject__c(TestText__c = 'AAA');
    TestObject__c t2 = new TestObject__c(TestText__c = 'BBB');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotPredicate.newInstance(LikePredicate.newInstance('TestText__c', 'A%')))
      .Execute();

    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts[0].Id);
  }

  // GREATER THAN OR EQUALS
  @isTest static void GreaterThanOrEqualsIntegerPredicate() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(GreaterThanOrEqualsPredicate.newInstance('TestCurrency__c', 2))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }

  // GREATER THAN
  @isTest static void SimpleGreaterThanPredicate() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(GreaterThanPredicate.newInstance('TestCurrency__c', 1))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }

  // LESS THAN
  @isTest static void SimpleLessThanOrEqualsPredicate() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(LessThanOrEqualsPredicate.newInstance('TestCurrency__c', 1))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }
  
  // LESS THAN
  @isTest static void SimpleLessThanPredicate() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(LessThanPredicate.newInstance('TestCurrency__c', 2))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }
  // IN
  @isTest static void In_StringList() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1');
    TestObject__c t2 = new TestObject__c(TestText__c = '2');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestText__c', new List<String> { '1', '5' }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }
  @isTest static void In_IntegerList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestCurrency__c', new List<Integer> { 1, 5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }
  @isTest static void In_LongList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestCurrency__c', new List<Long> { (long)1, (long)5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  } 
  @isTest static void In_DecimalList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestCurrency__c', new List<Decimal> { (decimal)1, (decimal)5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }  
  @isTest static void In_DoubleList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestCurrency__c', new List<Double> { (double)1, (double)5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }
  @isTest static void In_DateList() {
    TestObject__c t1 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,1));
    TestObject__c t2 = new TestObject__c(TestDate__c = Date.newInstance(2013,1,1));
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestDate__c', new List<Date> { Date.newInstance(2012,1,1), Date.newInstance(2010,1,1) }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  } 
  @isTest static void In_DateTimeList() {
    TestObject__c t1 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,1,10,0,0));
    TestObject__c t2 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2013,1,1,10,0,0));
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(InPredicate.newInstance('TestDateTime__c', new List<DateTime> { DateTime.newInstance(2012,1,1,10,0,0), DateTime.newInstance(2001,1,1,10,0,0) }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }

  // NOT IN
  @isTest static void NotIn_StringList() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1');
    TestObject__c t2 = new TestObject__c(TestText__c = '2');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestText__c', new List<String> { '1', '5' }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }
  @isTest static void NotIn_IntegerList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestCurrency__c', new List<Integer> { 1, 5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }
  @isTest static void NotIn_LongList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestCurrency__c', new List<Long> { (long)1, (long)5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  } 
  @isTest static void NotIn_DecimalList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestCurrency__c', new List<Decimal> { (decimal)1, (decimal)5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }  
  @isTest static void NotIn_DoubleList() {
    TestObject__c t1 = new TestObject__c(TestCurrency__c = 1);
    TestObject__c t2 = new TestObject__c(TestCurrency__c = 2);
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestCurrency__c', new List<Double> { (double)1, (double)5 }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }
  @isTest static void NotIn_DateList() {
    TestObject__c t1 = new TestObject__c(TestDate__c = Date.newInstance(2012,1,1));
    TestObject__c t2 = new TestObject__c(TestDate__c = Date.newInstance(2013,1,1));
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestDate__c', new List<Date> { Date.newInstance(2012,1,1), Date.newInstance(2010,1,1) }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  } 
  @isTest static void NotIn_DateTimeList() {
    TestObject__c t1 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2012,1,1,10,0,0));
    TestObject__c t2 = new TestObject__c(TestDateTime__c = DateTime.newInstance(2013,1,1,10,0,0));
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(NotInPredicate.newInstance('TestDateTime__c', new List<DateTime> { DateTime.newInstance(2012,1,1,10,0,0), DateTime.newInstance(2001,1,1,10,0,0) }))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }

  // INCLUDES
  @isTest static void Includes_String() {
    TestObject__c t1 = new TestObject__c(TestMultiSelect__c = 'One;Two;Three;Four;Five');
    TestObject__c t2 = new TestObject__c(TestMultiSelect__c = 'Four;Five;Six;Seven');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(IncludesPredicate.newInstance('TestMultiSelect__c', 'Three'))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
  }
  @isTest static void Includes_StringArray() {
    TestObject__c t1 = new TestObject__c(TestText__c = '1', TestMultiSelect__c = 'One;Two;Three;Four;Five');
    TestObject__c t2 = new TestObject__c(TestText__c = '2', TestMultiSelect__c = 'Four;Five;Six;Seven');
    TestObject__c t3 = new TestObject__c(TestText__c = '3', TestMultiSelect__c = 'Seven;Eight;Nine;Ten');
    insert t1;
    insert t2;
    insert t3;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(IncludesPredicate.newInstance('TestMultiSelect__c', new List<String>{'Two', 'Three', 'Ten'}))
      .OrderBy(OrderBy.FirstBy('TestText__c', OrderBy.OrderDirection.ASCENDING))
      .Execute();
    Test.stopTest();

    System.assertEquals(2, ts.size());
    System.assertEquals(t1.Id, ts.get(0).Id);
    System.assertEquals(t3.Id, ts.get(1).Id);
  }

  // EXCLUDES
@isTest static void Excludes_String() {
    TestObject__c t1 = new TestObject__c(TestMultiSelect__c = 'One;Two;Three;Four;Five');
    TestObject__c t2 = new TestObject__c(TestMultiSelect__c = 'Four;Five;Six;Seven');
    insert t1;
    insert t2;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(ExcludesPredicate.newInstance('TestMultiSelect__c', 'Three'))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t2.Id, ts.get(0).Id);
  }
  @isTest static void Excludes_StringArray() {
    TestObject__c t1 = new TestObject__c(TestMultiSelect__c = 'One;Two;Three');
    TestObject__c t2 = new TestObject__c(TestMultiSelect__c = 'Two;Three;Four');
    TestObject__c t3 = new TestObject__c(TestMultiSelect__c = 'Three;Four;Five');
    TestObject__c t4 = new TestObject__c(TestMultiSelect__c = 'Four;Five;Six');
    insert t1;
    insert t2;
    insert t3;
    insert t4;

    Test.startTest();
    TestObject__c[] ts = (TestObject__c[])
      SimpleSOQLQuery.newInstance(TestObject__c.SObjectType)
      .Predicate(ExcludesPredicate.newInstance('TestMultiSelect__c', new List<String>{'Two', 'Three'}))
      .Execute();
    Test.stopTest();

    System.assertEquals(1, ts.size());
    System.assertEquals(t4.Id, ts.get(0).Id);
  }
}
