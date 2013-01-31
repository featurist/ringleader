Server = require '../src/server'.Server
Job Queue = require '../src/memory_job_queue'.Memory Job Queue
Socket Io Agent Emitter = require '../src/socket_io/socket_io_agent_emitter'.Socket Io Agent Emitter
Server Log = require './stubs/stub_server_log'.Stub Server Log

Stub Agent Namer = require './stubs/stub_agent_namer'.Stub Agent Namer
Child Process Agent = require '../src/child_process_agent'.Child Process Agent
Socket Io Client = require '../src/socket_io/socket_io_client'.Socket Io Client

describe 'server with socket io agents'
    
    it 'triggers job execution on remote agents' @(done)
        
        namer = @new Stub Agent Namer()
        
        agent emitter = @new Socket Io Agent Emitter (1337, namer)
        job queue = @new Job Queue()
        server = @new Server (agent emitter, job queue)
        log = @new Server Log (server)
        
        agent = @new Child Process Agent 'agent 1'
        
        job queue.enqueue { command = 'echo howdy' }
        job queue.enqueue { command = 'echo hello' }
        job queue.enqueue { command = 'echo hola'  }
        
        @new Socket Io Client (agent) 'http://127.0.0.1:1337'
        
        set timeout
            log.events.should.eql [
                [ 'job enqueued', 'echo howdy' ]
                [ 'job enqueued', 'echo hello' ]
                [ 'job enqueued', 'echo hola' ]
                [ 'agent started job', 'agent 1', 'echo howdy' ]
                [ 'agent stdout', 'agent 1', "howdy\n" ]
                [ 'agent exit', 'agent 1', 0 ]
                [ 'agent started job', 'agent 1', 'echo hello' ]
                [ 'agent stdout', 'agent 1', "hello\n" ]
                [ 'agent exit', 'agent 1', 0 ]
                [ 'agent started job', 'agent 1', 'echo hola' ]
                [ 'agent stdout', 'agent 1', "hola\n" ]
                [ 'agent exit', 'agent 1', 0 ]
            ]
            done()
        200
        
        
    