Parakeet.Views.recentTweetsForm = Backbone.View.extend({
  template: JST['root/recent_tweets_form'],

  events: {
    'submit form': 'handleSubmit'
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON().user;
    Backbone.history.navigate('#/users/' + formData.username);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    return this;
  }
});