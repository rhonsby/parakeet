Parakeet.Views.mutualFollowShow = Backbone.View.extend({
  template: JST['follows/mutual_follow'],

  initialize: function (options) {
    this.users = new Parakeet.Collections.Users();
    this.users.fetchMutualFollows({
      userOne: options.userOne,
      userTwo: options.userTwo
    });

    this.listenTo(this.users, 'sync', this.render);
    this.listenTo(this.users, 'sync', this.turnOffSpin);

    this.addSpin();
  },

  addSpin: function () {
    var spinner = new Spinner().spin();
    $('#mutual-follows-form').after(spinner.el);
  },

  turnOffSpin: function () {
    $('.spinner').remove();
  },

  render: function () {
    var renderedContent = this.template({ users: this.users });
    this.$el.html(renderedContent);
    return this;
  }
});