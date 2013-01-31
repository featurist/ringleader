Child Process Agent = require '../src/child_process_agent'.Child Process Agent
Agent Log = require './stubs/stub_agent_log'.Stub Agent Log

describe 'child process agent'

    it 'emits stdout before exiting' @(done)
        agent = @new Child Process Agent
        log = @new Agent Log (agent)
        agent.start job { command = 'echo foo' }
        agent.once 'exit'
            log.events.should.eql [
                ['started job', 'echo foo']
                ['stdout', "foo\n"]
                ['exit', 0]
            ]
            done ()
   
    it 'emits stderr before exiting' @(done)
        agent = @new Child Process Agent
        log = @new Agent Log (agent)
        agent.start job { command = 'jibberish command' }
        agent.once 'exit'
            log.events.should.eql [
                ['started job', 'jibberish command']
                ['stderr', "execvp(): No such file or directory\n"]
                ['exit', 127]
            ]
            done ()
    
    it 'times out' @(done)
        agent = @new Child Process Agent
        log = @new Agent Log (agent)
        agent.start job { command = 'sleep 0.1', timeout = 50 }
        agent.once 'job timed out'
            log.events.should.eql [
                ['started job', 'sleep 0.1']
                ['job timed out', 'sleep 0.1']
            ]
            done ()
    
