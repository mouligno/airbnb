require 'mangopay'


# configuration
MangoPay.configure do |c|
  c.preproduction = true
  c.client_id = ENV['MANGOPAY_CLIENT_ID']
  c.client_passphrase = ENV['MANGOPAY_CLIENT_PASSWORD']
end


# # get some user by id
# john = MangoPay::User.fetch(john_id) # => {FirstName"=>"John", "LastName"=>"Doe", ...}


# # update some of his data
# MangoPay::NaturalUser.update(john_id, {'LastName' => 'CHANGED'}) # => {FirstName"=>"John", "LastName"=>"CHANGED", ...}


# # get all users (with pagination)
# pagination = {'page' => 1, 'per_page' => 8} # get 1st page, 8 items per page
# users = MangoPay::User.fetch(pagination) # => [{...}, ...]: list of 8 users data hashes
# pagination # => {"page"=>1, "per_page"=>8, "total_pages"=>748, "total_items"=>5978}


# # get John's bank accounts
# accounts = MangoPay::BankAccount.fetch(john_id) # => [{...}, ...]: list of accounts data hashes (10 per page by default)


# # error handling
# begin
#   MangoPay::NaturalUser.create({})
# rescue MangoPay::ResponseError => ex

#   ex # => #<MangoPay::ResponseError: One or several required parameters are missing or incorrect. [...] FirstName: The FirstName field is required. LastName: The LastName field is required. Nationality: The Nationality field is required.>

#   ex.details # => {
#              #   "Message"=>"One or several required parameters are missing or incorrect. [...]",
#              #   "Type"=>"param_error",
#              #   "Id"=>"5c080105-4da3-467d-820d-0906164e55fe",
#              #   "Date"=>1409048671.0,
#              #   "errors"=>{
#              #     "FirstName"=>"The FirstName field is required.",
#              #     "LastName"=>"The LastName field is required.", ...},
#              #   "Code"=>"400",
#              #   "Url"=>"/v2/.../users/natural"
#              # }
# end

# MangoPay::NaturalUser.create({
#   "FirstName": "Victor",
#   "LastName": "Hugo",
#   "Address": {
#     'AddressLine1' => "1 rue des Misérables",
#     'AddressLine2' => "Au fond de la cour",
#     'City' => "Paris",
#     'PostalCode' => "75000",
#     'Country' => "FR"
#   },
#   "Birthday": 1300186358,
#   "Nationality": "FR",
#   "CountryOfResidence": "FR",
#   "Occupation": "Writer",
#   "IncomeRange": "6",
#   "ProofOfIdentity": nil,
#   "ProofOfAddress": nil,
#   "PersonType": "NATURAL",
#   "Email": "victor@hugo.com",
#   "Tag": "custom tag",
# })
