namespace :destroy_orphans do
  desc "Destroy Orphane object in DB"
  task destroy_orphan_assignments: :environment do

    people_ids = Person.all.pluck(:id)

    assignment_people_ids = Assignment.all.pluck(:person_id)

    @count1 = (0)

    assignment_people_ids.each do |person_id|
      if !people_ids.include? person_id
        assignment_to_destroy = Assignment.find_by(person_id: person_id)
        if assignment_to_destroy.destroy
          puts person_id
          puts " destroyed!"
          @count1 += 1
        else
          puts "! destroyed (not destroyed!)"
        end
      end
    end

    location_ids = Location.all.pluck(:id)

    assignment_location_ids = Assignment.all.pluck(:location_id)

    @count2 = 0

    assignment_location_ids.each do |location_id|
      if !location_ids.include? location_id
        assignment_to_destroy = Assignment.find_by(location_id: location_id)
        if assignment_to_destroy.destroy
          puts location_id
          puts " destroyed!"
          @count2 += 1
        else
          puts "! destroyed (not destroyed!)"
        end
      end
    end
    puts '-----------------------------------------------'
    puts @count1.to_s + " Assignments(no person id) destroyed!"
    puts @count2.to_s + " Assignments(no location id) destroyed!"

    puts (@count1+@count2).to_s + " Total Assignments destroyed!"


  end
end
