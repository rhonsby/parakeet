Parakeet.Views.mutualFollowForm = Backbone.View.extend({
  template: JST['root/mutual_follow_form'],

  events: {
    'submit form': 'handleSubmit'
  },

  handleSubmit: function (event) {
    event.preventDefault();
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    return this;
  }
});