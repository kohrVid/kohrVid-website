(function() {
  var navUnfix, navigation;

  $(document).ready(function() {
    return $(".close").click(function() {
      return $(".alerts").hide();
    });
  });

  $(window).resize(function() {
    return navigation();
  });

  $(window).scroll(function() {
    return navigation();
  });

  navigation = function() {
    var menu, navbar;
    menu = $('#hide-on-scroll');
    navbar = $('#navbar');
    if (window.innerWidth < 768) {
      if ($(this).scrollTop().valueOf() >= navbar.height()) {
        navbar.removeClass("position-relative");
        navbar.addClass("position-fixed");
        return menu.addClass("hidden");
      } else if ($(this).scrollTop().valueOf() <= 3) {
        return navUnfix(navbar, menu);
      }
    } else if (window.innerWidth >= 768) {
      return navUnfix(navbar, menu);
    }
  };

  navUnfix = function(navbar, menu) {
    navbar.removeClass("position-fixed");
    navbar.addClass("position-relative");
    return menu.removeClass("hidden");
  };

}).call(this);
