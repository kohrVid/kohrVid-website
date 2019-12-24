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

        <p>
          I've split up my portfolio into "Personal Projects" and "Clients" just
          for clarity. However, I'm not currently contracting so the client list
          is quite low.
        </p>

        <div className="row">
          <main className="col-lg-8 col-md-9 col-sm-8 col-xs-12">
            <ul className="diamond-list">
              <li className="padded-li">
                <span className="fake-link" onClick={this.projectsContainerOpen}>Personal Projects</span>
              </li>
              <li className="padded-li">
                <span className="fake-link" onClick={this.clientsContainerOpen}>Clients</span>
              </li>
            </ul>
          </main>
        </div>
      </div>
    );
  }
}

export default App;
