Parakeet.Views.mutualFollow = Backbone.View.extend({
  template: JST['root/mutual_follow'],

  events: {
    'submit form': 'handleSubmit'
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON().user;

    if (this.mutualFollowShow) this.mutualFollowShow.remove();

    this.mutualFollowShow = new Parakeet.Views.mutualFollowShow({
      userOne: formData.user_one,
      userTwo: formData.user_two
    });

    this.$('.follows').html(this.mutualFollowShow.render().$el);
  },

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    return this;
  }
});