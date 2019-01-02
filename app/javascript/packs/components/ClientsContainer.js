import React, { Component  } from 'react'
import axios from 'axios'
import Modal from 'react-modal';

class ClientsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      clients: [],
      modalIsOpen: false
    };
    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  componentDidMount() {
    axios.get('http://localhost:3000/clients.json')
      .then(response => {
        this.setState({clients: response.data})
      })
      .catch(error => console.log(error))
  }

  truncate(str, len) {
    if (str.length > len) {
      return str.substring(0, len) + "..."
    } else {
      return str
    }
  }

  openModal() {
     this.setState({modalIsOpen: true});

  }

  afterOpenModal() {
     // references are now sync'd and can be accessed.
    //  this.subtitle.style.color = '#f00';
    //
  }

  closeModal() {
     this.setState({modalIsOpen: false});

  }

  render() {
    return (
      <div>
        <p>
          Many of the informal projects I've worked on can be found on my
          &nbsp;<a href="https://github.com/kohrVid">GitHub</a> page (which
            contains links to the apps that I've deployed to Heroku). The
            following is a list of my previous clients.
        </p>

        <ul>
          {this.state.clients.map(
            (client) => {
              return(
                <li className="tile" key={client.id} onClick={this.openModal}>
                  <img src={client.logo_url.url} className="fancybox" />
                  <div>
                    {client.client_name}
                  </div>
                  <div className="desc">
                    {this.truncate(client.description, 26)}
                  </div>


                  <Modal
                    isOpen={this.state.modalIsOpen}
                    onAfterOpen={this.afterOpenModal}
                    onRequestClose={this.closeModal}
                    //style=
                    contentLabel="Example Modal"
                  >
                      <img src={client.image_url.url} />
                      <div className="description">
                        <strong><u><a href={client.client_url}>{client.client_name} - {client.client_url.replace(/((https?)\:\/+(w+\.)?)/i, "")}</a></u></strong>
                        <p>
                          {client.description}
                          <strong><a href={client.pdf.url}>[PDF]</a></strong>
                        </p>
                      </div>
                  </Modal>
                </li>
              )
            }
          )}
        </ul>
      </div>
    );
  }
}

export default ClientsContainer

/*
 * TODO
                  <noscript>
                    <%=link_to "Site", client.client_url %>|
                    <% unless client.image_url.blank? %><%=link_to_unless client.image_url.blank?, "Screenshot", image_path(client.image_url.url) %>|<% end %>
                    <%= link_to "PDF", (client.pdf.to_s) %>|
                  </noscript>
                    <div className="screenshot" id="client-{client.id}">
                    </div>
        */
