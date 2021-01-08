'use strict';

// require('dotenv').config();
const http = require('http');
const port = process.env.SRV_PORT || '8888';

const swap = require('./swap');

swap.set('port', port);

const server = http.createServer(swap)

server.listen(port);

server.on('error', (error) => {
  console.error('error found', error)
});

server.on('listening', () => {
  console.log('Server running at ', port)
});
