Parakeet.Views.mutualFollowShow = Backbone.View.extend({
  template: JST['follows/mutual_follow'],

  initialize: function (options) {
    this.users = new Parakeet.Collections.Users();
    this.users.fetchMutualFollows({
      userOne: options.userOne,
      userTwo: options.userTwo
    });

    this.listenTo(this.users, 'sync', this.render);
  },

  render: function () {
    var renderedContent = this.template({ users: this.users });
    this.$el.html(renderedContent);
    return this;
  }
});