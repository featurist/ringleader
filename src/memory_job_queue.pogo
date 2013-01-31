exports.Memory Job Queue = require './emitter'.create emitter {
    
    constructor () =
        self.jobs = []
    
    enqueue (job) =
        self.jobs.push (job)
        self.emit 'enqueue' (job)
    
    dequeue () =
        job = self.jobs.shift ()
        self.emit 'dequeue' (job)
        job
    
}