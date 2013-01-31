# Ringleader

An experimental, distributed job queue for node.js

## How?

### Start the server on one machine

    ring server 8765

### Start agents on other machines

    ring agent http://server:8765

### Enqueue jobs

    ring enqueue http://server:8765 echo omg

##### That's all for now

Don't go using it for anything real!