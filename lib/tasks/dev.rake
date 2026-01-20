puts "Loading dev sample_data task..."
unless Rails.env.production?
  namespace :dev do
    desc "Add sample data"
    task sample_data: :environment do
      puts "-- Clearing existing data --"

      # Delete all existing records
      LearningItem.destroy_all
      Reflection.destroy_all
      Interview.destroy_all
      JobApplication.destroy_all
      User.destroy_all

      puts "-- Adding sample data --"

      puts "-- Adding users --"

      names = [
        "aaliyah",
        "benett",
        "cassius",
        "devon",
        "estefani",
        "fabio",
        "gina"
      ]

      names.each do |name|
        user = User.find_or_create_by(email: "#{name}@example.com") do |u|
          puts "-- Adding user: #{u.email} --"
          u.password = "password"
        end
      end
      puts "-- Finished adding users --"

      puts "-- Adding job applicatons --"

      10.times do
        
        name = names.sample
        email = "#{name}@example.com"
        user = User.find_by(email: email)

        job_app = JobApplication.create(
          user: user,
          company_name: Faker::Company.name,
          role: Faker::Company.profession,
          due_date: Faker::Date.forward(days: 23),
          applied_on: Faker::Date.between(from: 2.days.ago, to: Date.today),
          status: ["applied", "interviewing", "rejected"].sample
        )
        puts "-- Added job application for #{user.email} at #{job_app.company_name} --"

        2.times do
          interview = Interview.create(
            application_id: job_app.id,
            date_of: Faker::Date.forward(days: 23),
            interview_type: ["screening", "technical", "behavorial", "final"].sample,
            notes: Faker::TvShows::MichaelScott.quote,
            outcome: ["pending", "passed", "rejected"].sample
          )
          puts "-- Added interview for #{user.email} at #{job_app.company_name} --"

            reflection = Reflection.create(
              interview_id: interview.id,
              negative_notes: Faker::TvShows::BojackHorseman.quote,
              positive_notes: Faker::Quote.yoda,
              primary_gap: ["technical_skills", "communication", "experience", "problem_solving", "preparation", "other"].sample
            )
            puts "-- Added reflection for #{interview.id} at #{job_app.company_name} --"

              2.times do 
                learning_item = LearningItem.create(
                  reflection_id: reflection.id,
                  description: Faker::TvShows::HeyArnold.quote,
                  status: ["unaddressed", "pending", "improved"].sample,
                  category: ["technical", "behavioral", "system_design", "other"].sample
                )
                puts "-- Added learning item for #{reflection.id} at #{job_app.company_name} --"
            end 
          end
        end
        puts "-- Finished adding sample data --- "
      end
    end
  end
