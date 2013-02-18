var _ = require('lodash');
var child_process = require('child_process');
var spawn = child_process.spawn;
var fs = require('fs');
var path = require('path');
var net = require('net');
var events = require('events');
var util = require('util');

var mkdirp = require('mkdirp').sync;
var tmpDir = path.resolve(__dirname + '/tmp/');
mkdirp(tmpDir);

var defaults = {
  executable : 'OpenSees',
  executeArgs : ['--no-prompt'],
  autoRestart : true,
  tclDir : path.resolve(__dirname + '/tcl'),
  initScript : 'init.tcl',
  ipcMethod : 'domain_socket',
  tcpPort : 8124
};

util.inherits(OpenSees, events.EventEmitter);
function OpenSees(config) {
  events.EventEmitter.call(this);
  this.options = _.defaults(config || {}, defaults);
  var self = this;

  this.interpreter = spawn(this.options.executable, this.options.executeArgs);
  
  this.interpreter.stdout.on('data', function(data){
    self.emit('stdout', data.toString());
  });
  this.interpreter.stderr.on('data', function(data){
    self.emit('stderr', data.toString());
  });

  fs.readFile(this.options.tclDir + '/' + this.options.initScript, 'utf8', function(err, data) {
    if (err) {
      self.emit('error', err);
    } else {
      self.interpreter.stdin.write(data);
    }
    // if (self.modelId) {
    //   initDomainSocket(self.modelId);
    // }
    self.emit('initialized');
    self.initialized = true;
  });
};

OpenSees.prototype.formatCommand = formatCommand;
function formatCommand(str) {
  var cmds=[];
  var cmd;
  var result = '';
  str.trim().split(/[\n;]/).forEach(function(s) {
        var cmd = s.trim().replace(/\s+/g, ' ');
    if (cmd !== '' && cmd[0] !== '#') {
      cmds.push(cmd);
    }
  });
  for (var i = -1, len = cmds.length; ++i < len;) {
    cmd = cmds[i].trim();
    result += cmd + ';';
  }
  result += "\n";
  return result;
}

OpenSees.prototype.interp = function(str) {
  this.interpreter.stdin.write(formatCommand(str));
};

module.exports = OpenSees;

// function OpenSees(config) {
//   this.options = _.defaults(config || {}, defaults);
//   var self = this;
//   console.log('args', this.executeArgs);
//   this.interpreter = spawn(this.executable, this.executeArgs);
  
//   this.interpreter.stdout.on('data', function(data){
//     self.emit('stdout', data.toString());
//   });
//   this.interpreter.stderr.on('data', function(data){
//     self.emit('stderr', data.toString());
//   });

//   var initDomainSocket = function(modelId) {
//     if (modelId) {
//       self.domainSocketServer = net.createServer(function(c) {
//         console.log('server connected');
//         c.on('end', function() {
//           console.log('server disconnected');
//         });
//         c.on('data', function(data) {
//           self.emit('json', data.toString());
//         });
//       });
//       var socketName = self.domainSocket = self.domainSocketPrefix + modelId + '.sock';
//       console.log('socket name:', socketName);
//       fs.unlink(socketName, function (err) {
//         if (err) {
//           console.log(err);
//         } else {
//           console.log('successfully deleted /tmp/hello');
//         }
//         self.domainSocketServer.listen(socketName, function() {
//           self.interp('json-set-domain-socket ' + socketName);
//         });
//       });
//     }
//   };

//   fs.readFile(this.initDir + '/' + this.initScriptName, 'utf8', function(err, data) {
//     if (err) {
//       self.emit('error', err);
//     } else {
//       self.interpreter.stdin.write(data);
//     }
//     if (self.modelId) {
//       initDomainSocket(self.modelId);
//     }
//     self.emit('initialized');
//     self.initialized = true;
//   });
  
// }


