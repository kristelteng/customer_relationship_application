require_relative "./contact.rb"
require_relative "./rolodex.rb"

class CRM
  attr_reader :name

  def initialize(name)
    @name = name
    @rolodex = Rolodex.new
  end

  def print_main_menu
    puts "\n== Main Menu =="
    puts "[1] Add a contact"
    puts "[2] Modify a contact"
    puts "[3] Display all contacts"
    puts "[4] Display one contact"
    puts "[5] Display an attribute"
    puts "[6] Delete a contact"
    puts "[7] Exit"
    puts "Enter a number:"
  end

  def print_modify_menu
    puts "\n== Modify Menu =="
    puts "[1] Last Name"
    puts "[2] First Name"
    puts "[3] Email"
    puts "[4] Note"
  end

  def main_menu
    while true
      print_main_menu
      input = gets.chomp.to_i
      return if input == 7
      choose_option(input)
    end
  end

  def choose_option(option)
    case option
    when 1 then add_contact
    when 2 then modify_contact
    when 3 then display_all_contacts
    when 4 then display_contact
    when 5 then display_attribute
    when 6 then delete_contact
    else
      puts "Invalid option. Try again!"
      return
    end
  end

  def add_contact
    print "First Name: "
    first_name = gets.chomp
    print "Last Name: "
    last_name = gets.chomp
    print "Email: "
    email = gets.chomp
    print "Note: "
    note = gets.chomp
    contact = Contact.new(first_name, last_name, email, note)
    @rolodex.add_contact(contact)
  end

  def display_all_contacts
    @rolodex.contacts.each do |id, contact|
      puts contact
    end
  puts
  end

  def modify(contact)    
    if contact == nil
      puts "No such contact!"
      return
    end
  
    puts "Please confirm changes for: "
    puts contact.to_s
    puts "yes or no"
    results = gets.chomp

    if results == "yes"
      print_modify_menu
      puts ""
      
      puts "Enter a number: "
      number = gets.chomp.to_i
      puts "Enter a value: "
      value = gets.chomp
      case number
      when 1
        # change last name
        # need to modify index
        old_last_name = contact.last_name
        contact.last_name = value
        @rolodex.modify_index(old_last_name, contact.first_name, contact)
      when 2
        # change last name
        # need to modify index
        old_first_name = contact.last_name
        contact.first_name = value
        @rolodex.modify_index(contact.last_name, old_first_name, contact)
      when 3
        contact.email = value
      when 4
        contact.note = value
      end
      puts "Modified contact to: #{contact.to_s}"
    end
  end

    # modify contact by id
  def modify_contact
     # prompt user for id
    puts "What id to modify?"
    id = gets.chomp.to_i
    # get contact from rolodex
    contact = @rolodex.get_contact_by_id(id)
    # call modify
    modify(contact)
  end
  
  def display_contact
    # 1. Prompt user for id
    puts "What is the ID?"
    id = gets.chomp.to_i
    # 2. Get contact from rolodex
    contact = @rolodex.get_contact_by_id(id)
    # 3. Print
    puts contact.to_s
  end

  def display_attribute
    # 1.Prompt user for attribute -(first, last, email)
    puts "Enter the last name"
    last_name = gets.chomp

    # 2.Get contact from rolodex
    @rolodex.contacts.each do |id, contact|
      # puts contact with same last_name
      if contact.last_name == last_name
        puts contact.to_s
      end
    end
  end

  def delete_contact
    # 1.Prompt user for id number
    puts "Enter id"
    id = gets.chomp.to_i

    # 2.Display contact + Confirm information
    puts "Please confirm information for: "
    contact = @rolodex.get_contact_by_id(id)
    puts contact.to_s
    puts ""

    puts "yes or no"
    results = gets.chomp

    if results == "yes"
      @rolodex.delete_contact(id)
    end
    puts "Contact has been deleted."
  end
end 

crm = CRM.new("Bitmaker Labs CRM")
crm.main_menu