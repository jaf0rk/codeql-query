import cpp

predicate isTargetCall(File f) {
    not f.getBaseName().matches("%test%")
    and
    not f.getBaseName().matches("bind.h")
    and
    not f.getBaseName().matches("callback.h")
    and
    not f.getBaseName().matches("callback_helpers.h")
    and
    not f.getBaseName().matches("bind_post_task.h")
    and
    not f.getBaseName().matches("timer.h")
    and
    not f.getBaseName().matches("task_runner.h")
    and
    not f.getBaseName().matches("barrier_callback.h")
    and
    not f.getBaseName().matches("%functional%")
    and
    not f.getBaseName().matches("bind_post_task_internal.h")
    and
    not f.getBaseName().matches("event_loop.cc")
    and
    not f.getBaseName().matches("%libc++%")
    and
    not f.getBaseName().matches("feature_list.h")
    and
    not f.getBaseName().matches("memory_reclaimer.h")
}


predicate inTargetFuncCallChain(
    Function caller, Function callee) {
    caller.calls+(callee)
}

string getCallChain(Function caller, Function callee) {
    // 基本情况：直接调用
    caller.calls(callee) and
    result = caller.getName() + " -> " + callee.getName()
    or
    // 递归情况：经过中间函数 mid
    exists(Function mid |
        caller.calls(mid) and
        mid.calls+(callee) and
        result = caller.getName() + " -> " + getCallChain(mid, callee)
    )
}
Function getAllCaller(Function f){
    result = f.getACallToThisFunction().getTarget()
}
