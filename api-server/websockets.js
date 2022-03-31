const WebSocket =  require('ws');
const QueryString = require('query-string');

function initialiseWebsockets(app) {
    const ws = new WebSocket.Server({noServer: true, path: '/websockets'});
    app.on("upgrade", (request, socket, head) => {
        ws.handleUpgrade(request, socket, head, socket => {
            ws.emit("connection", socket, request);
        });
    });

    ws.on("connection", (socket, request) => {
        console.log("Websocket client connection upgraded");
        let args = [];
        if(request.args) args = QueryString.parse(request.args);

        ws.on("message", message => {
            const parsedMessage = JSON.parse(message);
            if(parsedMessage.message == 'topic_post') {
                
            }
        });
    });

    return ws;
}

exports.initialiseWebsockets = initialiseWebsockets; 