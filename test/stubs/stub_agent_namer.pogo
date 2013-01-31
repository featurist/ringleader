exports.Stub Agent Namer () =
    self.count = 0
    self.name for (socket) = "agent #(++self.count)"
    self