Socket Io Agent = require './socket_io_agent'.Socket Io Agent

exports.Socket Io Agent Emitter = require '../emitter'.create emitter {
    
    constructor (port, namer) =
        namer := namer || socket id namer
        io = require('socket.io').listen (port)
        io.sockets.on 'connection' @(socket)
            socket.on 'ready' @(os)
                agent = @new Socket Io Agent (socket, namer.name for (socket), os)
                self.emit 'agent connected' (agent)
            
            socket.on 'enqueue' @(job)
                self.emit 'enqueue' (job)
        
}

socket id namer = {
    name for (socket) = socket.id
}
