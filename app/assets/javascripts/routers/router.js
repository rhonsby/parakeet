Parakeet.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'index',
    'tweets': 'tweets',
    'mutual-follows': 'mutualFollows',
    'users/:username': 'userShow'
  },

  index: function () {
    var rootIndexView = new Parakeet.Views.rootIndex();
    this._swapView(rootIndexView);
  },

  tweets: function () {
    var recentTweetsView = new Parakeet.Views.recentTweetsForm();
    this._swapView(recentTweetsView);
  },

  userShow: function (username) {
    var user = new Parakeet.Models.User({ username: username });
    user.fetchByUsername();

    var userShowView = new Parakeet.Views.userShow({ model: user });
    this._swapView(userShowView);
  },

  mutualFollows: function () {
    var mutualFollowForm = new Parakeet.Views.mutualFollowForm();
    this._swapView(mutualFollowForm);
  },

  _swapView: function (view) {
    if (this._currentView) {
      this._currentView.remove();
    }

    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});