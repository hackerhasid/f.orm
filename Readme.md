# F.ORM

F.ORM is meant as a natural Apex API to output SOQL and SOSL. All consumer-intended classes are instantiated via a _static_ `newInstance` method. All consumer-intended methods return the same type to allow chaining.

## Queries

There are 2 query types:

* `SimpleSOQLQuery` representing a "simple" (non-aggregate) SOQL query
* `SOSLQuery` representing a SOSL query

# Basic usage

Take a look at the tests for more info but here's a quick rundown to get you started:

## SOQL Query

#### Initialization

Start by initializing a new instance of SimpleSOQLQuery passing the type you want to query:

```apex
SimpleSOQLQuery.newInstance(Opportunity.SObjectType); // takes an SObjectType for when you know the type at compile time
SimpleSOQLQuery.newInstance('Opportunity'); // also takes a string for when you don't
```

#### Executing queries

`Execute()` executes the query. The simplest query you can build is just a select all:

```apex
// the `Execute()` method returns a List<SObject> so you'll probably want to cast that to the type you're working with
Opportunity[] ops = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType).Execute();
```

`First()` returns just the first element:

```apex
Opportunity opt = (Opportunity)SimpleSOQLQuery.newInstance(Opportunity.SObjectType).First();
```

#### Defining fields and relationships

_By default the query will return all fields on the object but not fields on child objects._

You can manually specify the fields you'd like returned by passing them to the `SelectFields` method.

You can pass a list:

```apex
Opportunity[] opts = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .SelectFields(new String[] { 'Id', 'Name', 'CreatedDate' })
  .Execute();
```

Or you can chain the SelectFields calls (this is especially useful for building dynamic queries):

```apex
Opportunity[] opts = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .SelectFields('Id')
  .SelectFields('Name')
  .SelectFields('CreatedDate')
  .Execute();
```

You can also define which child relationships to hydrate:

```apex
Opportunity[] opts = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .Include('Account') // include all Account__r fields from Opportunity
  .Execute();
```

#### Limiting & Ordering

You can limit and page the results returned using the `Limit` and `Offset` methods:

```apex
Opportunity[] opts = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .Limit(100) // limit query to 100 records
  .Offset(100) // skip the first 100
  .Execute();
```

You can order the results using the `OrderBy` method. It's easy to order by a single field:

```apex
Opportunity[] opts = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .OrderBy(OrderBy.FirstBy('Name', OrderDirection.DESCENDING))
  .Execute();
```

or by multiple fields:

```apex
Opportunity[] opts = (Opportunity[]) SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .OrderBy(
    OrderBy.FirstBy('Name', OrderDirection.DESCENDING)
    .ThenBy('CreatedDate', OrderDirection.ASCENDING)
  )
  .Execute();
```
## SOSL Query

#### Initialization

Start by initializing a new instance of SOSLQuery passing the query term:

```apex
  SOSLQuery.newInstance('Microsoft');
```
#### Executing queries

Like `SimpleSOQLQuery`, `SOSLQuery` provides `Execute()` and `First()` methods.

#### Returning

Build the returning clause using the `ReturningClause` class. Set the returning clause on the `SOSLQuery` class using the `AndReturning` method or `OnlyReturning` method (the former will allow you to build a returning clause for multiple types, the latter will only return a single type):

```apex
Account[] acts = (Account[])SOSLQuery.newInstance('Microsoft')
  .AndReturning(
    ReturningClause.newInstance(Account.getSObjectType())
      .SelectField('Id')
      .Predicate(EqualsPredicate.newInstance('LastActivityDate', Date.today()))
    )
  .Execute();
```

## Predicates

Every predicate supported by SOQL/SOSL is implemented:

both "simple" predicates:

* `EqualsPredicate` representing `=`
* `ExcludesPredicate` representing the `EXCLUDES` keyword
* `GreaterThanPredicate` representing `>`
* `GreaterThanOrEqualsPredicate` representing `>=`
* `IncludesPredicate` representing the `INCLUDES` keyword
* `InPredicate` representing the `IN` keyword
* `LessThanPredicate` representing `<`
* `LessThanOrEqualsPredicate` representing `<=`
* `LikePredicxate` representing the `LIKE` keyword
* `NotEqualsPredicate` representing `<>`
* `NotInPredicagte` representing the `NOT IN` keyword
* `NotPredicate` representing the `NOT` keyword

and "complex" predicates:

* `AndPredicate` representing the `AND` keyword
* `OrPredicate` representing the `OR` keyword

## TODO

There's a bunch of things still on the todo list (feel free to help - just create a PR!):

* Aggregates
* SOQL query lacks support for inferring all fields on related object when the related object can be of multiple types (currently just chooses the first object)
* `TYPEOF` keyword in SOQL queries
* `USING SCOPE` keyword in SOQL queries
* `WITH` keyword in SOQL queries
* `FOR` keyword in SOQL queries
* `NULLS FIRST|LAST` in ordering
* `convertCurrency()` in SOSL queries
* `toLabel()` in SOSL queries
* `UPDATE TRACKING|VIEWSTAT` in SOSL queries
* `WITH` keyword in SOSL queries

# References

https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_sosl_syntax.htm