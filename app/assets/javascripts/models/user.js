Parakeet.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users',

  fetchByUsername: function () {
    var url = 'api/users/' + this.escape('username');

    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'json',
      success: function () {
        alert('success!');
      },
      error: function () {
        alert("User doesn't exist!");
        Backbone.history.navigate('#/tweets', { trigger: true });
      }
    });
  }
});