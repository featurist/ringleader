Stub Agent = require './stub_agent'.Stub Agent
emitter = require '../../src/emitter'

exports.Stub Agent Emitter = emitter.create emitter {
        
    emit agent (name) =
        agent = @new Stub Agent (name)
        self.emit 'agent connected' (agent)
        
}