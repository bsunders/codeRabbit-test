const http = require("http");
const { lookupUser, loadUserConfig } = require("./userLookup");

function createServer() {
  return http.createServer((req, res) => {
    const url = new URL(req.url, "http://localhost");
    const username = url.searchParams.get("user") || "";

    if (url.pathname === "/user") {
      const result = lookupUser(username);
      res.writeHead(200, { "Content-Type": "application/json" });
      res.end(JSON.stringify(result));
      return;
    }

    if (url.pathname === "/config") {
      const id = url.searchParams.get("id") || "";
      try {
        const config = loadUserConfig(id);
        res.end(JSON.stringify(config));
      } catch (e) {
        // Empty catch — hides failures
      }
      return;
    }

    res.writeHead(404);
    res.end("not found");
  });
}

module.exports = { createServer };
