// Use your current Terraform output value for websocket_url.
// Current state value: wss://6l1107lff5.execute-api.ap-south-1.amazonaws.com/dev

const WS_URL = "wss://6l1107lff5.execute-api.ap-south-1.amazonaws.com/dev";

const ws = new WebSocket(WS_URL);

ws.onopen = () => {
  console.log("CONNECTED", WS_URL);

  // Route key in API Gateway is "sendMessage", so action must match.
  ws.send(
    JSON.stringify({
      action: "sendMessage",
      message: "Hello from browser"
    })
  );
};

ws.onmessage = (event) => {
  console.log("MESSAGE", event.data);
};

ws.onerror = (event) => {
  console.error("WEBSOCKET ERROR", event);
};

ws.onclose = (event) => {
  console.log("CLOSED", event.code, event.reason || "no reason");
};
