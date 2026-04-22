import utils.Containers
import utils.BindCallbacks

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
  c.getUnderlyingType() instanceof EasyFailContainerType
  and
  isExternalContainer(c)
select rbfs, c, callbackCall