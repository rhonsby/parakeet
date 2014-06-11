window.Parakeet = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Parakeet.Routers.Router({ $rootEl: $('#main-content') });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Parakeet.initialize();
});