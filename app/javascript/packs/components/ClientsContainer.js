import React, { Component  } from 'react';
import axios from 'axios';
import Modal from 'react-modal';

import { truncate, handleString, renderLink } from '../utils/StringUtils.js';
import { takeMeBack } from '../utils/ViewUtils.js';

class ClientsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      clients: [],
      modalIsOpen: false
    };
  }

  componentDidMount() {
    axios.get('/clients.json')
      .then(response => {
        this.setState({clients: response.data})
      })
      .catch(error => console.log(error))
  }

  toggleClientModal = () => {
    this.setState(state => ({
      modalOpen: !state.modaleOpen
    }));
  }

  openModal = (client) => {
    this.setState({
      modalIsOpen: true,
      name: client.client_name,
      url: client.client_url,
      logo: client.logo_url.url,
      screenshot: client.image_url.url,
      description: client.description,
      pdf: client.pdf.url
    });
  }

  afterOpenModal = () => {
  }

  closeModal = (client) => {
    this.setState({
      modalIsOpen: false,
      client: client
    });
  }

  render() {
    return (
      <div id="Clients">
        {takeMeBack()}
        <h1>
          Clients
        </h1>
        <p>
          Many of the informal projects I've worked on can be found on my
          &nbsp;<a href="https://github.com/kohrVid">GitHub</a> page (which
            contains links to the apps that I've deployed to Heroku). The
            following is a list of my previous clients.
        </p>

        <ul className="row">
          {this.state.clients.map(
            (client) => {
              return(
                <li className="col-lg-3 col-md-4 col-sm-6 col-xs-12" key={client.id} onClick={() => this.openModal(client)}>
                  <img src={client.logo_url.url} />
                  <div>
                    {client.client_name}
                  </div>
                  <div className="desc">
                    {truncate(client.description, 26)}
                  </div>
                </li>
              )
            }
          )}
        </ul>

        <Modal
          appElement={document.getElementById('Clients')}
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          type="fullscreen"
          className="modal"
        >
          <button className="close-button pull-right" onClick={this.closeModal}>×</button>
          <img src={handleString(this.state.screenshot)} />
          <div className="description">
            <strong><u><a href={this.state.url}>
              {this.state.name} - {handleString(this.state.url).replace(/((https?)\:\/+(w+\.)?)/i, "")}
            </a></u></strong>
            <p>
              {handleString(this.state.description)}
              &nbsp;{renderLink("[PDF]", this.state.pdf)}
            </p>
          </div>
        </Modal>
      </div>
    );
  }
}

export default ClientsContainer
