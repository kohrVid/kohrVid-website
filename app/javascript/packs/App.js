import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import logo from './logo.svg';
import ClientsContainer from './components/ClientsContainer';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      modalIsOpen: false
    };
    this.portfolioContainerOpen = this.portfolioContainerOpen.bind(this);
    this.clientContainerOpen = this.clientContainerOpen.bind(this);
  }

  clientContainerOpen() {
    ReactDOM.render(<ClientsContainer />, document.getElementById('Portfolio'));
  }

  portfolioContainerOpen() {
    ReactDOM.render(<PortfolioContainer />, document.getElementById('Portfolio'));
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
            <a href="#" onClick={this.portfolioContainerOpen}>Previous Projects</a>
          </li>
          <li className="padded-li">
          <a href="#" onClick={this.clientContainerOpen}>Clients</a></li>
        </ul>
      </div>
    );
  }
}

export default App;
