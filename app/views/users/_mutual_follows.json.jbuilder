json.cache! [mutual_follows.length] do
  json.users users, partial: 'users/basic_user', as: :user
  json.mutual_follows mutual_follows, partial: 'users/basic_user', as: :user
end