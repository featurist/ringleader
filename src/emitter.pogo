Event Emitter = require 'events'.Event Emitter

exports.create emitter (proto) =

    Emitter () =
        if (proto.constructor)
            proto.constructor.apply (this, arguments)
        
        return (this)

    Emitter.prototype = Object.create( Event Emitter.prototype )
    
    for each @(method) in (Object.keys (proto))
        if (method != 'constructor')
           Emitter.prototype.(method) = proto.(method)
    
    Emitter