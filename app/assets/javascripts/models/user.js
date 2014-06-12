Parakeet.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users',

  parse: function (resp) {
    var tweets = resp.tweets;
    if (tweets) {
      this.tweets().set(tweets);
      delete resp.tweets;
    }
    return resp;
  },

  fetchByUsername: function () {
    var url = 'api/users/' + this.escape('username');
    var user = this;

    $.ajax({
      url: url,
      type: 'GET',
      dataType: 'json',
      success: function (resp) {
        user.set(user.parse(resp));
        user.trigger('sync');
      },
      error: function () {
        alert("User doesn't exist!");
        $('.spinner').remove();
        Backbone.history.navigate('#/tweets', { trigger: true });
      }
    });
  },

  tweets: function () {
    if (!this._tweets) {
      this._tweets = new Parakeet.Collections.Tweets();
    }

    return this._tweets;
  }
});