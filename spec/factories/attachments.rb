FactoryBot.define do
  factory :attachment do
    file File.open("#{Rails.root}/spec/files/test_file1.txt")
    trait :attachable do
    end
  end
end
