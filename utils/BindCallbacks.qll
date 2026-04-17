import cpp
import SmartPointer
import ReverseTracker

/**
 * All OnceCallback class
 */
class OnceCallbackClass 
extends ClassTemplateInstantiation {
    OnceCallbackClass() { 
        this.getSimpleName() = "OnceCallback"
        and
        this.getFile()
        .getBaseName() = "callback.h"
    }
}

/**
 * All RepeatingCallback class
 */
class RepeatingCallbackClass 
extends ClassTemplateInstantiation {
    RepeatingCallbackClass() {
        this.getSimpleName() = "RepeatingCallback"
        and
        this.getFile()
        .getBaseName() = "callback.h"
    }
}

/**
 * All Callback class
 */
class CallbackClass 
extends ClassTemplateInstantiation {
    CallbackClass(){
        this instanceof OnceCallbackClass
        or
        this instanceof RepeatingCallbackClass
    }
}

/**
 * Get all callback objects
 */
class CallbackCall 
extends FunctionCall{
    CallbackCall(){
        this.getTarget()
        instanceof 
        CallbackRun
    }
    
    /**
     * Gets the expression to the left of the function 
     * name or function pointer variable name. The underlying 
     * call is getQualifier, and the result is the execution 
     * result of getQualifier
     */
    Expr getCallbackReceiver(){
        result = this.getQualifier()
    }
}

/**
 * Get once callback objects
 */
class OnceCallbackCall 
extends FunctionCall{
    OnceCallbackCall(){
        this.getTarget() 
        instanceof 
        OnceCallbackRun
    }

    /**
     * Gets the expression to the left of the function 
     * name or function pointer variable name. The underlying 
     * call is getQualifier, and the result is the execution 
     * result of getQualifier
     */
    Expr getCallbackReceiver(){
        result = this.getQualifier()
    }
}

/**
 * Get repeating callback objects
 */
class RepeatingCallbackCall 
extends FunctionCall{
    RepeatingCallbackCall() {
        this.getTarget()
        instanceof 
        RepeatingCallbackRun
    }
    
    /**
     * Gets the expression to the left of the function 
     * name or function pointer variable name. The underlying 
     * call is getQualifier, and the result is the execution 
     * result of getQualifier
     */
    Expr getCallbackReceiver(){
        result = this.getQualifier()
    }
}

/**
 * Get OnceCallback::Run function
 */
cached class OnceCallbackRun 
extends Function{
    cached OnceCallbackRun(){
        this.getName() = "Run"
        and
        this.getDeclaringType()
        .stripType()
        .(Class)
        .getABaseClass*() 
        instanceof 
        OnceCallbackClass
    }
}

/**
 * Get RepeatingCallback::Run function
 */
cached class RepeatingCallbackRun 
extends Function{
    cached RepeatingCallbackRun(){
        this.getName() = "Run"
        and
        this.getDeclaringType()
        .stripType()
        .(Class)
        .getABaseClass*() 
        instanceof 
        RepeatingCallbackClass
    }
}

/**
 * Get All Callback::Run function
 */
cached class CallbackRun 
extends Function{
    cached CallbackRun(){
        this instanceof OnceCallbackRun
        or
        this instanceof RepeatingCallbackRun
    }
}

/**
 * base::BindOnce or base::BindRepeating function
 */
class BindFunction 
extends Function{
    BindFunction(){
        this.
        getName() in ["BindOnce", "BindRepeating"] 
        and
        this.getNamespace().getName() = "base"
    }
}

/**
 * base::BindRepeating function
 */
class BindRepeatingFunction
extends Function{
    BindRepeatingFunction(){
        this.
        getName() = "BindRepeating"
        and
        this.getNamespace().getName() = "base"
    }
}

/**
 * base::BindOnce function
 */
class BindOnceFunction
extends Function{
    BindOnceFunction(){
        this.
        getName() = "BindOnce"
        and
        this.getNamespace().getName() = "base"
    }
}

/**
 * A call to base::BindOnce or base::BindRepeating.
 */
class BindFuncCall 
extends FunctionCall{
    BindFuncCall(){
        this
        .getTarget() 
        instanceof 
        BindFunction
    }
}

/**
 * A call to base::BindRepeating.
 */
class BindRepeatingFuncCall 
extends FunctionCall{
    BindRepeatingFuncCall(){
        this
        .getTarget() 
        instanceof 
        BindRepeatingFunction
    }
}

/**
 * A call to base::BindOnce
 */
class BindOnceFuncCall 
extends FunctionCall{
    BindOnceFuncCall(){
        this
        .getTarget() 
        instanceof 
        BindOnceFunction
    }
}

/**
 * Get OnceCallback instances
 */
class OnceCallbackInstances
extends Expr{
    OnceCallbackInstances(){
        this = any(OnceCallbackCall cc)
        .getCallbackReceiver()
    }

    OnceCallbackCall getCall(){
        exists(OnceCallbackCall cc | 
            cc.getCallbackReceiver() = this
            and
            result = cc)
    }
}

/**
 * Get RepeatingCallback instances
 */
class RepeatingCallbackInstances
extends Expr{
    RepeatingCallbackInstances(){
        this = any(RepeatingCallbackCall cc)
        .getCallbackReceiver()
    }

    RepeatingCallbackCall getCall(){
        exists(RepeatingCallbackCall cc | 
            cc.getCallbackReceiver() = this
            and
            result = cc)
    }
}

/**
 * Get all Callback instances
 */
class CallbackInstances
extends Expr{
    CallbackInstances(){
        this = any(CallbackCall cc)
        .getCallbackReceiver()
    }

    CallbackCall getCall(){
        exists(CallbackCall cc | 
            cc.getCallbackReceiver() = this
            and
            result = cc)
    }
}

