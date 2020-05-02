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
