(function () {
  function applyLayoutClass() {
    var width = window.innerWidth || document.documentElement.clientWidth;
    var body = document.body;
    if (!body) {
      return;
    }

    body.classList.remove("gp-layout-hd", "gp-layout-uhd");
    if (width >= 2560) {
      body.classList.add("gp-layout-uhd");
    } else if (width >= 1920) {
      body.classList.add("gp-layout-hd");
    }

    if (width >= 992) {
      body.classList.remove("sidebar-collapse");
      body.classList.remove("sidebar-mini");
      document.documentElement.style.setProperty("--gp-sidebar-w", "240px");
    }
  }

  function init() {
    applyLayoutClass();
    if (window.jQuery) {
      window.jQuery(document).on("shiny:connected", applyLayoutClass);
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }

  window.addEventListener("resize", applyLayoutClass);
})();
