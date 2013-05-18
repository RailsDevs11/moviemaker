require 'machinist/active_record'

User.blueprint do
  first_name            { "first_name-#{sn}" }
  last_name             { "last_name-#{sn}"}
  email                 { "first_last-#{sn}@exmaple.com" }
  password              { "secret_word" }
  password_confirmation { "secret_word" }
end

Image.blueprint do
  title                 {"image"}
  imageable             {Gallery.make!}
  #comments              { [Comment.make!] * 3 } # 3 transactions
#comments(3)
end

Gallery.blueprint do
  title                 {"gallery"}
end

Comment.blueprint do
  comment               {"thanks"}
  ownerable             { User.make! }
  commerterable         { Image.make!}
end
