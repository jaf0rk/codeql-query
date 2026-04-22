import utils.Containers
import utils.BindCallbacks

predicate isExternalContainer(Expr c) {
  // 情况1：成员字段（没有创建函数，视为外部）
  exists(FieldAccess fa | fa = c)
  or
  // 情况2：全局变量（没有创建函数，视为外部）
  exists(VariableAccess va |
    va = c and
    va.getTarget() instanceof GlobalVariable
  )
  or
  // 情况3：函数参数（创建函数是调用方，不是当前函数）
  exists(VariableAccess va |
    va = c and
    va.getTarget() instanceof Parameter
  )
}

from 
  IteratorGetting ig, 
  Expr container,
  Variable it
where
  container = ig.getContainer()
  and
  isExternalContainer(container)
  and
  it = ig.getIterator()
select it, ig, container

/*

predicate getCallbackCall(
  Stmt smt, FunctionCall fc, Expr c) {

  // 情况1：直接在 smt 的 AST 子树中找到回调调用
  fc = smt.getAChild*() 
  and
  fc.getTarget() instanceof CallbackRun 
  or
  // 情况2：smt 中存在一个函数调用 fc2，其目标函数体内递归包含回调调用
  exists(FunctionCall fc2, Function f |
    fc2 = smt.getAChild*() and
    f = fc2.getTarget() and
    getCallbackCall(f.getBlock(), fc, c)
  )
}

from 
  RangeBasedForStmt rbfs, 
  Expr c, 
  Stmt smt, 
  FunctionCall callbackCall
where 
  c = rbfs.getRange()
  and 
  smt = rbfs.getStmt()
  and 
  getCallbackCall(smt, callbackCall, c)
  and
  isExternalContainer(c)
select rbfs, c, callbackCall
*/