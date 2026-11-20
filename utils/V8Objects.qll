import cpp

class V8LocalBase 
extends ClassTemplateInstantiation {
    V8LocalBase() {
        this.getSimpleName() = "LocalBase"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-local-handle.h"
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Local
extends ClassTemplateInstantiation {
    V8Local() {
        this.getSimpleName() = "Local"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-local-handle.h"
    }
}

class V8PersistentBase
extends ClassTemplateInstantiation {
    V8PersistentBase() {
        this.getSimpleName() = "PersistentBase"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-persistent-handle.h"
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Persistent 
extends ClassTemplateInstantiation {
    V8Persistent() {
        this.getSimpleName() = "Persistent"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-persistent-handle.h"
    }
}

class V8HandleScope extends Class {
    V8HandleScope() {
        this.getName() = "HandleScope"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-local-handle.h"
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Data extends Class {
    V8Data() {
        this.getName() = "Data"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-data.h"
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Value extends Class {
    V8Value() {
        this.getName() = "Value"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-value.h"
        and
        this.getABaseClass() instanceof V8Data
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Object extends Class {
    V8Object() {
        this.getName() = "Object"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-object.h"
        and
        this.getABaseClass() instanceof V8Value
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Function extends Class {
    V8Function() {
        this.getName() = "Function"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-function.h"
        and
        this.getABaseClass() instanceof V8Object
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Context extends Class {
    V8Context() {
        this.getName() = "Context"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-context.h"
        and
        this.getABaseClass() instanceof V8Data
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}

class V8Isolate extends Class {
    V8Isolate() {
        this.getName() = "Isolate"
        and
        this.getNamespace().getName() = "v8"
        and
        this.getFile().getBaseName() = "v8-isolate.h"
    }

    FunctionCall memberFunctionCall(string func_name){
        result.getTarget().getName() = func_name
        and
        result.getTarget() = this.getAMemberFunction()
    }
}