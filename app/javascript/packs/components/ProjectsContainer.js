import React, { Component  } from 'react'

class ProjectsContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      projects: []
    }
  }

  render() {
    return (
      <h1>
        Projects
      </h1>
    )
  }
}

export default ProjectsContainer
