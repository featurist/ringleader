exports.Stub Agent Log (agent) =
    self.events = []
    
    agent.on 'started job' @(job)
        self.events.push ['started job', job.command]
        
    agent.on 'stdout' @(output)
        self.events.push ['stdout', output]
    
    agent.on 'stderr' @(output)
        self.events.push ['stderr', output]

    agent.on 'exit' @(code)
        self.events.push ['exit', code]
    
    agent.on 'job timed out' @(job)
        self.events.push ['job timed out', job.command]
    
    self