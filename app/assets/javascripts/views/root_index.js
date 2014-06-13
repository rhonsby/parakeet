Parakeet.Views.rootIndex = Backbone.View.extend({
  template: JST['root/index'],

  className: 'root-index',

  render: function () {
    var renderedContent = this.template();
    this.$el.html(renderedContent);
    return this;
  }
});