import utils.Containers
import utils.BindCallbacks


predicate hasCallbackCall(
  Function f, CallbackCall cc) {
  cc.getEnclosingFunction() = f
  or
  exists(FunctionCall subCall | 
    f = subCall.getEnclosingFunction()
    and
    hasCallbackCall(subCall.getTarget(), cc)
  )
}

CallbackCall getCallbackCall(
  IteratorGetting ig) {
  result  = ig.getIteratorGetterCall()
  .getASuccessor+()
  and
  exists(VariableAccess va |
    va.getTarget() = ig.getIterator()
    and
    va.getEnclosingFunction() = result.getEnclosingFunction()
    and
    result.getLocation()
    .getStartLine() < va.getLocation().getStartLine()
  )
  /*
  or
  (
    exists(FunctionCall subCall | 
      ig.getIteratorGetterCall()
      .getASuccessor+() = subCall
      and
      hasCallbackCall(
        subCall.getTarget(), result
      )
    )
  )
  */
}

from 
  IteratorGetting ig, 
  Expr container,
  Variable iterator,
  CallbackCall cc
where
  container = ig.getContainer()
  and
  container.getUnderlyingType() instanceof EasyFailContainerType
  and
  isExternalContainer(container)
  and
  iterator = ig.getIterator()
  and
  cc = getCallbackCall(ig)
select iterator, ig, cc
