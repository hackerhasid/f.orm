public abstract class BasicPredicate implements IPredicate {
  public String field { public get; private set; }
  public String value { public get; private set; }

  public BasicPredicate() {}
  public BasicPredicate (String field, String value) {
    this.field = field;
    this.value = value;
  }
}
