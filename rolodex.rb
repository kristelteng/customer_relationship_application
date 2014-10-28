class Rolodex
  attr_reader :contacts

  def initialize
    @contacts = {}   
    @@index = 0
  end

  def add_contact(contact)
    contact.id = @@index
    @@index += 1
    @contacts << contact
  end

  def get_contact(id)
    contact = @contacts[id]
  end
end
