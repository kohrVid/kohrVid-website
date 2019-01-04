import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import logo from './logo.svg';
import ClientsContainer from './components/ClientsContainer';
import ProjectsContainer from './components/ProjectsContainer';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      modalIsOpen: false
    };
  }

  clientsContainerOpen() {
    ReactDOM.render(<ClientsContainer />, document.getElementById('Portfolio'));
  }

  projectsContainerOpen() {
    ReactDOM.render(<ProjectsContainer />, document.getElementById('Portfolio'));
  }

  render() {
    return (
      <div className="App" id="Portfolio">
        <div className="App-header">
          <h1>
            Portfolio
          </h1>
        </div>
        <ul className="diamond-list">
          <li className="padded-li">
            <span className="fake-link" onClick={this.projectsContainerOpen}>Previous Projects</span>
          </li>
          <li className="padded-li">
          <span className="fake-link" onClick={this.clientsContainerOpen}>Clients</span></li>
        </ul>
      </div>
    );
  }
}

export default App;
