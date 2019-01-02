import React, { Component } from 'react';
import logo from './logo.svg';
import ClientsContainer from './components/ClientsContainer'

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>
            Clients
          </h1>
          <ClientsContainer />
        </div>
      </div>
    );
  }
}

export default App;
