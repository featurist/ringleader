Child Process Agent = require '../src/child_process_agent'.Child Process Agent
Agent Log = require './stubs/stub_agent_log'.Stub Agent Log

describe 'the command line interface'
    
    run cli (command line) =
        cli = @new Child Process Agent
        cli.start job { command = command line }
        cli
    
    it 'connects a server to agent(s) and enqueues jobs' @(done)
        server = run cli './bin/ring server 1665'
        server.once 'stdout'
            agent = run cli './bin/ring agent 1665'
            enqueuer = run cli './bin/ring enqueue 1665 echo howdy'
            server.on 'stdout' @(data)
                if (data.index of '(exit) 0' > -1)
                    server.abort()
                    agent.abort()
                    enqueuer.abort()
                    done()