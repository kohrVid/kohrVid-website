import React, { Component  } from 'react';
import ReactDOM from 'react-dom';

export const truncate = (str, len) => {
  if (str.length > len) {
    return str.substring(0, len) + "..."
  } else {
    return str
  }
}

export const handleString = (str) => {
  if (str === undefined || str == null) {
    return ""
  } else {
   return str
  }
}

export const renderLink = (link, url) => {
  if (handleString(url) !== "") {
   return <strong><a href={handleString(url)}>{link}</a></strong>
  }
}
