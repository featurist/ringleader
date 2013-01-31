Socket Io Agent Emitter = require '../socket_io/socket_io_agent_emitter'.Socket Io Agent Emitter
Job Queue = require '../memory_job_queue'.Memory Job Queue
Server = require '../server'.Server
Server Log = require '../console_server_log'.Console Server Log

exports.run server (port) =
    
    agent emitter = @new Socket Io Agent Emitter (port)
    job queue = @new Job Queue()
    server = @new Server (agent emitter, job queue)
    
    @new Server Log (server, port)