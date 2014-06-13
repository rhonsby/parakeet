Parakeet.Collections.Users = Backbone.Collection.extend({
  model: Parakeet.Models.User,
  url: 'api/users',

  fetchMutualFollows: function (options) {
    var userOne = options.userOne;
    var userTwo = options.userTwo;
    var users = this;

    $.ajax({
      url: '/api/mutual_follows',
      type: 'GET',
      dataType: 'json',
      data: {
        userOne: userOne,
        userTwo: userTwo
      },
      success: function (resp) {
        alert('success!');
        users.set(resp.users, { parse: true });
        users.mutualFollows().set(resp.mutual_follows, { parse: true });
        users.trigger('sync');
      },
      error: function () {
        alert("User(s) doesn't exist!");
        $('.spinner').remove();
      }
    });
  },

  mutualFollows: function () {
    if (!this._mutualFollows) {
      this._mutualFollows = new Parakeet.Collections.Users();
    }

    return this._mutualFollows;
  }
});