io = require 'socket.io-client'
os = require 'os'

os details = {
    hostname = os.hostname()
    type = os.type()
    arch = os.arch()
    platform = os.platform()
}

exports.Socket Io Client (agent, host) =

    console.log "[connecting to #(host)]"
    
    socket = io.connect (host)
    
    socket.on 'connect'
        console.log '[socket connected]'
        socket.emit 'ready' (os details)

    agent.on 'stdout' @(data)
        socket.emit 'stdout' (data.to string())
        
    agent.on 'stderr' @(data)
        socket.emit 'stderr' (data.to string())
        
    agent.on 'exit' @(code)
        socket.emit 'exit' (code)
    
    agent.on 'job timed out' @(job)
        socket.emit 'job timed out' (job)

    socket.on 'execute' @(command)
        agent.start job { command = command }

    socket.on 'disconnect'
        console.log '[disconnected]'

    socket
