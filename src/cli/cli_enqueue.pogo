Socket Io Enqueuer = require '../socket_io/socket_io_enqueuer'.Socket Io Enqueuer

exports.enqueue (host, job) =
    enqueuer = @new Socket Io Enqueuer (host)
    enqueuer.enqueue { command = job.join " " }
        process.exit(0)