Parakeet.Views.userShow = Backbone.View.extend({
  template: JST['users/show'],
  className: 'user-content',

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model, 'sync', this.turnOffSpin);

    this.addSpin();
  },

  addSpin: function () {
    var spinner = new Spinner().spin();
    $('.main-nav').append(spinner.el);
  },

  turnOffSpin: function () {
    $('.spinner').remove();
  },

  render: function () {
    var renderedContent = this.template({ user: this.model });
    this.$el.html(renderedContent);
    return this;
  }
});