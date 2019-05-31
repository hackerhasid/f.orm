global with sharing class OrderBy {
  global Enum OrderDirection { ASCENDING, DESCENDING }
  public class SingleOrdering {
    private String fieldName = null;
    private OrderDirection direction = null;

    public SingleOrdering(String field) {
      this.fieldName = field;
    }
    public SingleOrdering(String field, OrderDirection dir) {
      this(field);
      this.direction = dir;
    }

    override public String toString() {
      String orderString = fieldName;
      if (direction == OrderDirection.ASCENDING) {
        orderString += ' ASC';
      } else if (direction == OrderDirection.DESCENDING) {
        orderString += ' DESC';
      }

      return orderString;
    }
  }

  private List<SingleOrdering> allOrderings = new List<SingleOrdering>();

  @deprecated
  // Use .FirstBy() instead
  global static OrderBy NewInstance() {
    return new OrderBy();
  }

  global static OrderBy FirstBy(String fieldName) {
    OrderBy o = new OrderBy();
    return o.ThenBy(fieldName);
  }
  global static OrderBy FirstBy(String fieldName, OrderBy.OrderDirection direction) {
    OrderBy o = new OrderBy();
    return o.ThenBy(fieldName, direction);
  }

  @deprecated
  // Use ThenBy() instead
  global OrderBy ByField(String fieldName) {
    allOrderings.add(new SingleOrdering(fieldName));
    return this;
  }
  @deprecated
  // Use ThenBy() instead
  global OrderBy ByField(String fieldName, OrderDirection direction) {
    allOrderings.add(new SingleOrdering(fieldName, direction));
    return this;
  }
  global OrderBy ThenBy(String fieldName) {
    allOrderings.add(new SingleOrdering(fieldName));
    return this;
  }
  global OrderBy ThenBy(String fieldName, OrderDirection direction) {
    allOrderings.add(new SingleOrdering(fieldName, direction));
    return this;
  }

  override global String toString() {
    String orderString = '';
    for (SingleOrdering so : allOrderings) {
      if (!String.IsBlank(orderString)) {
        orderString += ', ';
      }
      orderString += String.valueOf(so);
    }
    return orderString;
  }
}
