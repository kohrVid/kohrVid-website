import React, { Component  } from 'react';
import axios from 'axios';
import Modal from 'react-modal';
import { truncate, handleString, renderLink } from '../utils/StringUtils.js';
import { renderTags, takeMeBack } from '../utils/ViewUtils.js';

class ProjectsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: [],
      modalIsOpen: false
    };
  }

  componentDidMount() {
    axios.get('http://localhost:3000/projects.json')
      .then(response => {
        this.setState({projects: response.data})
      })
      .catch(error => console.log(error))
  }

  toggleProjectModal = () => {
    this.setState(state => ({
      modalOpen: !state.modaleOpen
    }));
  }

  openModal = (project) => {
    this.setState({
      modalIsOpen: true,
      name: project.name,
      repoUrl: project.repo_url,
      appUrl: project.app_url,
      image: project.image.url,
      description: project.description,
      languages: project.languages,
      draft: project.draft
    });
  }

  afterOpenModal = () => {
  }

  closeModal = (project) => {
    this.setState({
      modalIsOpen: false,
      project: project
    });
  }

  render() {
    return (
      <div id="Projects">
        {takeMeBack()}
        <h1>
          Projects
        </h1>
        <p>
          Many of the informal projects I've worked on can be found on my
          &nbsp;<a href="https://github.com/kohrVid">GitHub</a> page (which
            contains links to the apps that I've deployed to Heroku). The
            following is a list of my previous projects.
        </p>

        <ul className="row">
          {this.state.projects.map(
            (project) => {
              if (project.draft === false) {
                return(
                  <li className="col-lg-3 col-md-4 col-sm-6 col-xs-12" key={project.id} onClick={() => this.openModal(project)}>
                    <img src={project.image.thumb.url} />
                    <div>
                      {project.name}
                    </div>
                    <div className="desc">
                      {truncate(project.description, 26)}
                    </div>
                  </li>
                )
              }
            }
          )}
        </ul>

        <Modal
          appElement={document.getElementById('Projects')}
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          type="fullscreen"
          className="modal"
        >
          <button className="close-button pull-right" onClick={this.closeModal}>×</button>
          <img src={handleString(this.state.image)} />
          <div className="description">
            <strong><u><a href={this.state.repoUrl}>
              {this.state.name}
            </a></u></strong>
            <p>
              {handleString(this.state.description)}
            </p>
            <a href={this.state.repoUrl}>Repo URL</a> | <a href={this.state.appUrl}>App URL</a>
            {renderTags(this.state.languages)}
          </div>
        </Modal>
      </div>
    );
  }
}

export default ProjectsContainer
