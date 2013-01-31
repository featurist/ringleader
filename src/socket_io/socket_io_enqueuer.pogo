io = require 'socket.io-client'

exports.Socket Io Enqueuer = require '../emitter'.create emitter {
    
    constructor (host) =
        self.host = host
    
    enqueue (job, callback) =
        socket = io.connect (self.host)

        socket.on 'connect'
            socket.emit 'enqueue' (job)
            self.emit 'enqueued' (job)
            callback (nil, false)
}