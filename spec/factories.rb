FactoryGirl.define do
	factory :user do
		name	"Geert Dobbels"
		email	"dobbels.geert@gmail.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
end
