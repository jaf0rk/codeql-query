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

Function getAllCaller(Function f){
    result = f.getACallToThisFunction().getTarget()
}
