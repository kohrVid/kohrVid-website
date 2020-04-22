import 'social-likes-next/lib/social-likes_flat.css';
import 'social-likes-next/lib/social-likes_birman.css';
import './css/posts.css';

import socialLikes from 'social-likes-next';

var socialLikesButtons = {
  hacker_news: {
    service: 'hacker_news',
    icon: './assets/hacker-news.svg',
    clickUrl: 'http://news.ycombinator.com/submitlink?u={url}'
  }
};

document.addEventListener("DOMContentLoaded", function (event) {
  socialLikes(document.getElementById('share'), socialLikesButtons);
});
