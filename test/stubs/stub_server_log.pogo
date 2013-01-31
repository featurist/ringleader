exports.Stub Server Log (server) =
    self.events = []

    server.on 'job enqueued' @(job)
        self.events.push ['job enqueued', job.command]
    
    server.on 'agent started job' @(agent, job)
        self.events.push ['agent started job', agent.name, job.command]
        
    server.on 'agent stdout' @(agent, output)
        self.events.push ['agent stdout', agent.name, output]
    
    server.on 'agent stderr' @(agent, output)
        self.events.push ['agent stderr', agent.name, output]

    server.on 'agent exit' @(agent, code)
        self.events.push ['agent exit', agent.name, code]
    
    self