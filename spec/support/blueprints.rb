require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Need.blueprint do
  priority { 1 }
end

Need.blueprint(:with_fact_checker) do
  priority { 1 }
  fact_checkers(1)
end

FactChecker.blueprint do
  contact
end

Contact.blueprint do
  email { "joe_contact@alphagov.co.uk" }
end
