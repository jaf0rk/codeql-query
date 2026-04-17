import cpp


class DCHECK extends Macro {
    DCHECK(){
        this.getName() = "DCHECK"
    }
}

class CHECK extends Macro {
    CHECK(){
        this.getName() = "CHECK"
    }
}

class UNSAFE_TODO extends Macro {
    UNSAFE_TODO() {
        this.getName() = "UNSAFE_TODO"
    }
}

class UNSAFE_BUFFERS extends Macro {
    UNSAFE_BUFFERS() {
        this.getName() = "UNSAFE_BUFFERS"
    }
}

class UNSAFE_BUFFER_USAGE extends Macro {
    UNSAFE_BUFFER_USAGE(){
        this.getName() = "UNSAFE_BUFFER_USAGE"
    }
}

class IPCZ_UNSAFE_TODO extends Macro {
    IPCZ_UNSAFE_TODO(){
        this.getName() = "IPCZ_UNSAFE_TODO"
    }
}

class IPCZ_UNSAFE_BUFFERS extends Macro {
    IPCZ_UNSAFE_BUFFERS(){
        this.getName() = "IPCZ_UNSAFE_BUFFERS"
    }
}

class IPCZ_UNSAFE_BUFFER_USAGE extends Macro {
    IPCZ_UNSAFE_BUFFER_USAGE(){
        this.getName() = "IPCZ_UNSAFE_BUFFER_USAGE"
    }
}




class DCHECK_ACCESS extends MacroAccess {
    DCHECK_ACCESS(){
        this.getMacroName() = "DCHECK"
    }
}

class CHECK_ACCESS extends MacroAccess {
    CHECK_ACCESS(){
        this.getMacroName() = "CHECK"
    }
}

class UNSAFE_TODO_ACCESS extends MacroAccess {
    UNSAFE_TODO_ACCESS() {
        this.getMacroName() = "UNSAFE_TODO"
    }
}

class UNSAFE_BUFFER_ACCESS extends MacroAccess {
    UNSAFE_BUFFER_ACCESS() {
        this.getMacroName() = "UNSAFE_BUFFERS"
    }
}

class UNSAFE_BUFFER_USAGE_ACCESS extends MacroAccess {
    UNSAFE_BUFFER_USAGE_ACCESS(){
        this.getMacroName() = "UNSAFE_BUFFER_USAGE"
    }
}

class IPCZ_UNSAFE_TODO_ACCESS extends MacroAccess {
    IPCZ_UNSAFE_TODO_ACCESS(){
        this.getMacroName() = "IPCZ_UNSAFE_TODO"
    }
}

class IPCZ_UNSAFE_BUFFERS_ACCESS extends MacroAccess {
    IPCZ_UNSAFE_BUFFERS_ACCESS(){
        this.getMacroName() = "IPCZ_UNSAFE_BUFFERS"
    }
}

class IPCZ_UNSAFE_BUFFER_USAGE_ACCESS extends MacroAccess {
    IPCZ_UNSAFE_BUFFER_USAGE_ACCESS(){
        this.getMacroName() = "IPCZ_UNSAFE_BUFFER_USAGE"
    }
}