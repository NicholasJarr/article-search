100.times do
    Article.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph_by_chars(number: 300)
    )
end