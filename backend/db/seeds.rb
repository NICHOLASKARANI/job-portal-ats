# Create demo employer
employer_user = User.create!(
  email: 'employer@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: :employer
)

employer_user.create_employer_profile!(
  company_name: 'Tech Corp Inc.',
  company_description: 'Leading technology company',
  website: 'https://techcorp.com'
)

# Create demo candidate
candidate_user = User.create!(
  email: 'candidate@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: :candidate
)

candidate_user.create_candidate_profile!(
  full_name: 'John Doe',
  phone: '+1234567890',
  location: 'New York, NY',
  skills: 'Ruby on Rails, React, PostgreSQL'
)

# Create sample jobs
5.times do |i|
  employer_user.employer_profile.jobs.create!(
    title: "Software Engineer #{i+1}",
    description: "Exciting opportunity for a skilled software engineer to join our growing team.",
    requirements: "3+ years experience with Ruby on Rails, React, and PostgreSQL",
    location: ["New York, NY", "San Francisco, CA", "Remote"].sample,
    salary_range: "$80,000 - $120,000",
    employment_type: [0, 1, 2, 3, 4].sample,
    expiry_date: 30.days.from_now,
    status: 1
  )
end

puts "Seed data created successfully!"
puts "Demo employer: employer@example.com / password123"
puts "Demo candidate: candidate@example.com / password123"