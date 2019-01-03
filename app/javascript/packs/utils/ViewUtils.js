import React, { Component  } from 'react';
import ReactDOM from 'react-dom';

export const renderTags = (tags) => {
  console.log(tags)
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
}
