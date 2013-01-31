exports.Socket Io Agent = require '../emitter'.create emitter {
    
    constructor (socket, name, os) =
        self.socket = socket
        self.name = name
        self.os = os
        socket.on 'job timed out' @(job) @{ self.emit 'job timed out' (job) }
        socket.on 'os details' @(details) @{ self.emit 'os details' (details) }
        socket.on 'stdout' @(output) @{ self.emit 'stdout' (output) }
        socket.on 'stderr' @(output) @{ self.emit 'stderr' (output) }
        socket.on 'exit'   @(code)   @{ self.emit 'exit'   (code)   }
    
    start job (job) =
        self.socket.emit 'execute' (job.command)
        self.emit 'started job' (job)

}