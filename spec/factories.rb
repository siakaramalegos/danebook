include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :friend do
    accepter_id 2
    requester_id 1
  end

  factory :user do
    sequence(:first_name) {|n| "Foo#{n}"}
    last_name "Bar"
    email {"#{first_name}@bar.com"}
    password "password"

    factory :user_with_profile do
      after(:create) do |user|
        create(:profile, user_id: user.id)
      end
    end

    factory :user_with_posts do
      after(:create) do |user|
        create(:profile, user_id: user.id)
        create(:post_with_comment, user_id: user.id)
      end
    end
  end

  factory :profile do
    dob Date.new(1980, 1, 1)
    gender "female"
    user
  end

  factory :post do
    sequence(:content) {|n| "Lorem ipsum #{n}"}
    created_at Time.now
    user

    factory :post_with_comment do
      after(:create) do |post|
        create(:comment, commentable_id: post.id, commentable_type: 'Post', user_id: post.user.id)
      end
    end
  end

  factory :comment do
    content "Bacon"
    user
  end

  factory :photo do
    photo { fixture_file_upload(Rails.root.join('spec', 'support', 'test.jpg'), 'image/jpg') }
    user
  end

end