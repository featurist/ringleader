default port = 1337

exports.run (args) =
    service = args.shift()
    port = parse int(args.shift()) || default port
    host = if (port.to string().index of "http" != 0) @{ "http://127.0.0.1:#(port)" } else @{ port }

    if (service == 'server')
        require './cli_server'.run server(port)

    if (service == 'agent')
        require './cli_agent'.run agent(host)

    if (service == 'enqueue')
        require './cli_enqueue'.enqueue(host, args)