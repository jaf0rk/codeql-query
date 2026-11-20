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
}

predicate isVaild(File f) {
    not f.getAbsolutePath().matches("%test%")
    and
    not f.getAbsolutePath().matches("%functional%")
    and
    not f.getAbsolutePath().matches("%libc%")
    and
    not f.getAbsolutePath().matches("%/out/%")
    and
    not f.getAbsolutePath().matches("%/src/base/%")
    and
    isTargetCall(f)
}

Function getAllCaller(Function f){
    result = f.getACallToThisFunction().getTarget()
}

predicate reach(Function begin, Function end, int depth) {
    (
        depth in [0 .. 1024]
        and
        begin = end
    )
    or
    (
        depth in [0 .. 1024]
        and
        exists(
            FunctionCall fc | 
            fc.getEnclosingFunction() = begin
            and
            reach(fc.getTarget(), end, depth-1)
        )
    )
    
}