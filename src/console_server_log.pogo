sys = require 'sys'

exports.Console Server Log (server, port) =

    server.on 'job enqueued' @(job)
        log padded "(job enqueued) #(sys.inspect(job))"
    
    server.on 'agent started job' @(agent, job)
        log (agent, 'started job', job)
        
    server.on 'agent stdout' @(agent, output)
        log (agent, 'stdout', output)
    
    server.on 'agent stderr' @(agent, output)
        log (agent, 'stderr', output)

    server.on 'agent exit' @(agent, code)
        log (agent, 'exit', code)
    
    server.on 'agent job timed out' @(agent, job)
        log (agent, 'job timed out', job)
    
    log (agent, event, args) =
        log padded ("[agent #(agent.name)] (#(event)) #(sys.inspect (args))")

    log padded (message) =
        console.log ("         - #(message)")

    log padded "Server listening at http://127.0.0.1:#(port)/"

    self