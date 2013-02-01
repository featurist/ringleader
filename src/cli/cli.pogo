default port = 1337

(arg) as port =
    parse int(arg) || default port

(arg) as host =
    if ((arg) is a url) @{ arg } else @{ "http://127.0.0.1:#(arg)" }

(arg) is a url =
    arg.to string().index of ("http") == 0

cli = {
    
    server (args) =
        port = (args.shift()) as port
        require './cli_server'.run server(port)
    
    agent (args) =
        host = (args.shift()) as host
        require './cli_agent'.run agent(host)
    
    enqueue (args) =
        host = (args.shift()) as host
        require './cli_enqueue'.enqueue(host, args)
}

exports.run (args) =
    service = args.shift()
    cli.(service).call(self, args)
