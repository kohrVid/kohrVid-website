import React, { Component  } from 'react';
import ReactDOM from 'react-dom';

export const renderTags = (tags) => {
  if (tags !== undefined) {
   return (
    <ul className="tags p-l-0">
      {tags.split(",").map(
        (tag) => {
          return(<li>{tag}</li>)
        }
      )}
    </ul>
   )
  }
};

export const takeMeBack = () => {
  return (
    <div className="row">
      <div className="col-lg-3 col-lg-offset-9 col-md-3 col-md-offset-9 col-sm-3 col-sm-offset-9 col-xs-4 col-xs-offset-8 right-align">
        <a href="/portfolio">Back to Portfolio</a>
      </div>
    </div>
  )
}

export const handleEmptyState = (resource, resourceName, view) => {
  if (resource.length > 0) {
    return view
  } else {
    return emptyState(resourceName)
  }
}

const emptyState = (resourceName) => {
    return (
      <div>
        <p>
          Yeah...so I don't actually have any {resourceName}. I'm really sorry.
        </p>
        <p>
          Here's a corvid I saw on a roof garden!
        </p>
        <center>
          <img src="/assets/roof_bird.jpg" />
        </center>
      </div>
    )
  }
