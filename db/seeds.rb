password = ENV['DEFAULT_USER_PASSWORD']
raise "Set ENV['DEFAULT_USER_PASSWORD'] before seeding" unless password.present?

attachments_path = Rails.root.join('db', 'seeds', 'attachments')
avatars_path     = Rails.root.join('db', 'seeds', 'avatars')

action_attachment_files = Dir[attachments_path.join('*')]
avatar_files            = Dir[avatars_path.join('*')]

addresses = {
  prague: { street_name: 'Vodičkova', street_number: '41', city: 'Prague', postal_code: '11000', country_name: 'Czech Republic' },
  brno:   { street_name: 'Náměstí Svobody', street_number: '2', city: 'Brno',   postal_code: '60200', country_name: 'Czech Republic' }
}

def find_or_create_address(attrs)
  Address.find_or_create_by!(attrs)
end

addresses.each_value { |attrs| find_or_create_address(attrs) }

users = []
users << User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.first_name = 'Anna'
  u.last_name  = 'Admin'
  u.password   = password
  u.role       = :admin
  u.address    = Address.find_by(city: 'Prague')
end
users << User.find_or_create_by!(email: 'user1@example.com') do |u|
  u.first_name = 'Boris'
  u.last_name  = 'User'
  u.password   = password
  u.role       = :user
  u.address    = Address.find_by(city: 'Prague')
end
users << User.find_or_create_by!(email: 'user2@example.com') do |u|
  u.first_name = 'Cecilie'
  u.last_name  = 'User'
  u.password   = password
  u.role       = :user
  u.address    = Address.find_by(city: 'Brno')
end

users.each do |u|
  next if u.avatar.attached?
  avatar_file = avatar_files.sample
  u.avatar.attach(
    io: File.open(avatar_file),
    filename: File.basename(avatar_file)
  ) if avatar_file
end

project_attrs = [
  { name: 'Website Redesign', description: 'Full revamp of corporate website with new branding.' },
  { name: 'Mobile App',        description: 'Developing the native mobile application for iOS and Android.' }
]
projects = project_attrs.map do |attrs|
  Project.find_or_create_by!(name: attrs[:name]) do |p|
    p.description = attrs[:description]
  end
end

statuses = Task.statuses.keys
created_tasks = []
projects.each do |project|
  10.times do |i|
    t = Task.find_or_create_by!(subject: "#{project.name} Task #{i + 1}", project: project) do |task|
      task.description = "Auto-generated task for #{project.name}, step #{i + 1}."
      task.status      = statuses.sample
      task.user        = users.sample
    end
    created_tasks << t
  end
end

created_tasks.each do |task|
  rand(1..3).times do
    file_path = action_attachment_files.sample
    next unless file_path
    task.task_attachments.create!(note: "Attachment #{File.basename(file_path)}") do |att|
      att.file.attach(
        io: File.open(file_path),
        filename: File.basename(file_path)
      )
    end
  end
end