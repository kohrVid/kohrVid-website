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
  if (str === undefined) {
    return ""
  } else {
   return str
  }
}

export const renderLink = (link, url) => {
  if (url !== undefined) {
   return <strong><a href={handleString(url)}>{link}</a></strong>
  }
}
