emitter = require './emitter'
spawn = require 'child_process'.spawn

spawn process (command line) =
    args = command line.split ' '
    exe = args.shift()
    spawn (exe, args)

exports.Child Process Agent = emitter.create emitter {
    
    constructor (name: 'Child Process Agent') =
        self.name = name
    
    default abort time = 10 * 1000
    
    start job (job) =
        self.aborted = false
        clear timeout (self.abort timeout)

        self.abort timeout = set timeout
            self.abort ()
            self.emit 'job timed out' (job)
        (job.timeout || self.default abort time)

        self.child process = spawn process (job.command)
        
        self.child process.stdout.on 'data' @(data)
            self.unless aborted
                self.emit 'stdout' (data.to string())
    
        self.child process.stderr.on 'data' @(data)
            self.unless aborted
                self.emit 'stderr' (data.to string())
    
        self.child process.on 'exit' @(code)
            self.unless aborted
                clear timeout (self.abort timeout)
                set timeout
                    self.aborted = true
                    self.emit 'exit' (code)
                5
        
        self.emit 'started job' (job)
    
    unless aborted (action) =
        if (!self.aborted)
            action.call(self)
    
    abort () =
        clear timeout (self.abort timeout)
        self.aborted = true
        if (self.child process)
            self.child process.kill()
}