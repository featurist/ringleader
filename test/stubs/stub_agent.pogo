emitter = require '../../src/emitter'

exports.Stub Agent = emitter.create emitter {
    
    constructor (name) =
        self.name = name
    
    start job (job) =
        self.emit 'started job' (job)
        
        set timeout
            self.emit 'stdout' "STDOUT #(job.command)"
        3

        set timeout
            self.emit 'stderr' "STDERR #(job.command)"
        6
        
        set timeout
            self.emit 'exit' 123
        9

}

