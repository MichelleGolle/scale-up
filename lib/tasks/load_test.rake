require 'capybara/poltergeist'

desc "Simulate load against HubStub application"
task :load_test => :environment do
  #  4.times.map { Thread.new { browse } }.map(&:join)
  browse
end

def browse
  session = Capybara::Session.new(:poltergeist, timeout: 60)
  loop do
    session.visit("https://hubstub-scale-up.herokuapp.com/")

    #User list a ticket
    session.click_link("My Hubstub")
    session.click_link("List a Ticket")
    session.fill_in "session[email]", with: "demo+rachel@example.com"
    session.fill_in "session[password]", with: "password"
    session.click_link_or_button("Log in")
    puts "Login"
    session.select  "Les Miserables", from: "item[event_id]"
    session.fill_in "item[section]", with: "1"
    session.fill_in "item[row]", with: "1"
    session.fill_in "item[seat]", with: "1"
    session.fill_in "item[unit_price]", with: 100
    session.select  "Electronic", from: "item[delivery_method]"
    session.click_button("List Ticket")
    puts "New ticket created"
    #User logout
    session.click_link("Logout")
    puts "Logout"

    #Admin Login
    session.click_link("Login")
    session.fill_in "session[email]", with: "admin@admin.com"
    session.fill_in "session[password]", with: "password"
    session.click_link_or_button("Log in")
    puts "Admin Login"



    #Admin Edit Event
    session.click_link "Users"
    session.all("tr").sample.click_link "Store"
    puts "visited admin users index"
    session.click_link "Events"
    session.click_link "Manage Events"
    puts session.current_path
    session.all("tr").sample.click_link "Edit"
    session.fill_in "event[title]", with: ("A".."Z").to_a.shuffle.first(5).join
    session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
    session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
    session.click_button "Submit"
    puts "event edited by admin"

    # Admin logout
    session.click_link("Logout")
    puts "Admin logout"

    # Unregisted user browses
    session.click_link("Buy")
    session.click_link("All Tickets")
    puts "all tickets clicked"
    session.click_link("All")
    puts session.current_path
    session.click_link("Sports")
    session.click_link("Music")
    session.click_link("Theater")
    session.click_link("All")
    puts "sports searched"
    #Unregisted user adds item to cart
    session.all("p.event-name a").sample.click
    session.all("tr").sample.find(:css, "input.btn").click
    puts "one thing added to cart"
    #User registers and checks out
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.click_link("here")
    session.fill_in "user[full_name]", with: "Michelle"
    session.fill_in "user[display_name]", with: "mg"
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@sample.com"
    session.fill_in "user[street_1]", with: "dhjsakds"
    session.fill_in "user[city]", with: "Denver"
    session.select  "Colorado", from: "user[state]"
    session.fill_in "user[zipcode]", with: "80202"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")
    puts session.current_path
    puts "created user account"
  end
end
