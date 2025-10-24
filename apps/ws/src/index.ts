import WebSocket, { WebSocketServer } from 'ws';
import { prismaClient } from '@DB'

const PORT = process.env.PORT ? parseInt(process.env.PORT, 10) : 8080;

const wss = new WebSocketServer({ port: PORT }); 

wss.on('connection', function connection(ws: WebSocket) {
  console.log('New client connected');

  (async () => {
    try {
      const user = await prismaClient.user.create({
        data: {
          username: Math.random().toString(),
          password: Math.random().toString()
        }
      });
      console.log('Created user:', user);
      ws.send(`User created: ${JSON.stringify(user)}`);
    } catch (err) {
      console.error('Error creating user:', err);
      ws.send('Error creating user');
    }
  })();

  ws.on('message', function message(data) {
    console.log(`Received message: ${data}`);

    ws.send(`Server received: ${data}`);
  });

  ws.on('close', () => {
    console.log('Client disconnected');
  });

  ws.on('error', (err) => {
    console.error('WebSocket error:', err);
  });

  ws.send('Welcome to the WebSocket server!');
});

console.log(`WebSocket server is running on ws://localhost:${PORT}`);
