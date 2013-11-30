exports.Console Agent Log (agent) =
    log (event, arg) =
        console.log "[#(event)]"
        if (arg) @{ console.log (arg) }

    agent.on 'started job' @(job)
        log "started job" (job.command)

    agent.on 'stdout' @(output)
        log 'stdout' (output)

    agent.on 'stderr' @(output)
        log 'stderr' (output)

    agent.on 'exit' @(code)
        log "exit #(code)"

    agent.on 'job timed out' @(job)
        log "job timed out" (job.command)

    self