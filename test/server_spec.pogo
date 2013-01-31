Server = require '../src/server'.Server
Job Queue = require '../src/memory_job_queue'.Memory Job Queue
Agent Emitter = require './stubs/stub_agent_emitter'.Stub Agent Emitter
Server Log = require './stubs/stub_server_log'.Stub Server Log

describe 'server'
    
    it 'makes idle agents work off jobs' @(done)
        
        agent emitter = @new Agent Emitter()
        job queue = @new Job Queue()
        server = @new Server (agent emitter, job queue)
        log = @new Server Log (server)
        
        agent emitter.emit agent 'black'
        agent emitter.emit agent 'white'
        
        job queue.enqueue { command = 'echo howdy' }
        job queue.enqueue { command = 'echo hello' }
        job queue.enqueue { command = 'echo hola'  }
        
        set timeout
            log.events.should.eql [
                [ 'job enqueued', 'echo howdy' ]
                [ 'agent started job', 'black', 'echo howdy' ]
                [ 'job enqueued', 'echo hello' ]
                [ 'agent started job', 'white', 'echo hello' ]
                [ 'job enqueued', 'echo hola' ]
                [ 'agent stdout', 'black', 'STDOUT echo howdy' ]
                [ 'agent stdout', 'white', 'STDOUT echo hello' ]
                [ 'agent stderr', 'black', 'STDERR echo howdy' ]
                [ 'agent stderr', 'white', 'STDERR echo hello' ]
                [ 'agent exit', 'black', 123 ]
                [ 'agent started job', 'black', 'echo hola' ]
                [ 'agent exit', 'white', 123 ]
                [ 'agent stdout', 'black', 'STDOUT echo hola' ]
                [ 'agent stderr', 'black', 'STDERR echo hola' ]
                [ 'agent exit', 'black', 123 ]
            ]
            done()
        20
