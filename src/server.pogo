exports.Server = require './emitter'.create emitter {
    
    constructor (agent emitter, job queue) =
        self.job queue = job queue
        self.agents = {}
            
        agent emitter.on 'agent connected' @(agent)
            agent.idle = true
            self.agents.(agent.name) = agent
        
            agent.on 'started job' @(job)
                self.emit 'agent started job' (agent, job)
        
            agent.on 'stdout' @(output)
                self.emit 'agent stdout' (agent, output)

            agent.on 'stderr' @(output)
                self.emit 'agent stderr' (agent, output)

            agent.on 'exit' @(code)
                agent.idle = true
                self.emit 'agent exit' (agent, code)
                self.work off jobs()
            
            agent.on 'job timed out' @(job)
                agent.idle = true
                self.emit 'agent job timed out' (agent, job)
                self.work off jobs()
        
            self.work off jobs()
        
        agent emitter.on 'enqueue' @(job)
            job queue.enqueue (job)
        
        job queue.on 'enqueue' @(job)
            self.emit 'job enqueued' (job)
            self.work off jobs()
        
        self
    
    first idle agent () =
        for each @(key) in (Object.keys(self.agents))
            agent = self.agents.(key)
            if (agent.idle)
                
                return (agent)
        
        nil
    
    
    work off jobs () =
        if (agent = self.first idle agent()) 
            if (job = self.job queue.dequeue())
                agent.idle = false
                agent.start job (job)
                self.work off jobs()
}
