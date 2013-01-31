Child Process Agent = require '../child_process_agent'.Child Process Agent
Console Agent Log = require '../console_agent_log'.Console Agent Log
Socket Io Client = require '../socket_io/socket_io_client'.Socket Io Client

exports.run agent (host) =
    agent = @new Child Process Agent 'agent'
    @new Console Agent Log (agent)
    @new Socket Io Client (agent, host) 