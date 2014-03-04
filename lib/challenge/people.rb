class People
  extend Database

  def self.populate(db, array)
    Database.get_lines do |line, index|
      person = {}
      if index > 0
        fields = line.split(" ")
        person['last_name'] = fields[0]
        person['first_name'] = fields[1]
        person['gender'] = fields[2]
        person['fav_color'] = fields[3]
        person['dob'] = DateTime.strptime(fields[4],'%m-%d-%Y')
        array.push(person)
      end
    end
    return array
  end

  def self.sort(array, field1)
    puts "sorting by #{field1}..."
    array.sort! {|a, b| a[field1] <=> b[field1]}
  end

  def self.double_sort(array, field1, field2)
    puts "sorting by #{field1}, and then by #{field2}"
    array.sort! { |a, b| [a[field1], a[field2]] <=> [b[field1], b[field2]] }
  end

  def self.reverse(array, field1, field2)
    puts "sorting by #{field1}, and then reverse sorting by #{field2}"
    array.sort! do |a, b|
      [a[field1], b[field2]] <=> [b[field1], a[field2]]
    end
  end

  def self.sort_people(*field, people)
    if field[0].present? && field[1].blank?
      People.sort(people, field[0])
    elsif field[0].present? && field[1].present?
      field[2].present? && field[2] == "reverse" ? People.reverse(people, field[0], field[1]) : People.double_sort(people, field[0], field[1])
    else
      return people
    end
    return people
  end
end