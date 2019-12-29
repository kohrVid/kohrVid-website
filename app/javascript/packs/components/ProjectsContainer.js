import React, { Component  } from 'react';
import axios from 'axios';
import Modal from 'react-modal';
import { truncate, handleString, renderLink } from '../utils/StringUtils.js';
import { renderTags, takeMeBack, handleEmptyState } from '../utils/ViewUtils.js';

class ProjectsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: [],
      _404ImageUrl: "",
      modalIsOpen: false
    };
  }

  componentDidMount() {
    axios.get('/projects.json')
      .then(response => {
        console.log(response.data)
        this.setState({
          projects: response.data.projects,
          _404ImageUrl: response.data._404_image_url
        })
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

  projectsView = () => {
    return (
      <div>
        <p>
          Many of the personal projects I've worked on can be found on my
          &nbsp;<a href="https://github.com/kohrVid">GitHub</a> page (which also contains
          &nbsp;links to the apps that I've deployed to Heroku). The following
          is a sample of what I've worked on in the past:
        </p>

        <div className="row">
          <ul className="projects">
            {this.state.projects.map(
              (project) => {
                if (project.draft === false) {
                  return(
                    <li className="col-lg-3 col-md-4 col-sm-6 col-xs-10 fake-link" key={project.id} onClick={() => this.openModal(project)}>
                      <img src={project.image.thumb.url} />
                      <div>
                        {project.name}
                      </div>
                      <div className="desc">
                        {truncate(project.description, 50)}
                      </div>
                    </li>
                  )
                }
              }
            )}
          </ul>
        </div>

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
    )
  }

  render() {
    return (
      <div id="Projects">
        {takeMeBack()}
        <h1>
          Projects
        </h1>

        {
          handleEmptyState(
            this.state.projects,
            "projects",
            this.projectsView(),
            this.state._404ImageUrl
          )
        }
      </div>
    );
  }
}

export default ProjectsContainer
