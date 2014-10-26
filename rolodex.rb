class Rolodex
  attr_reader :contacts
  
  def initialize
    @contacts = {}
    @contacts_index = {}
    @@index = 0
  end

  def get_contact_by_id(id)
    contact = @contacts[id]
  end

  def delete_contact(id)
    @contacts.delete(id)
  end

  def get_contact_by_name(last_name, first_name)
    #define a key to get value
    name = "#{last_name}, #{first_name}"
    id = @contacts_index[name]
    return nil if id == nil
    contact = @contacts[id]
  end

  def modify_index(old_last_name, old_first_name, contact)
    old_name = "#{old_last_name}, #{old_first_name}"
    @contacts_index.delete(old_name)

    new_name = "#{contact.last_name}, #{contact.first_name}"
    @contacts_index[new_name] = contact.id
  end

  def add_contact(contact)
    contact.id = @@index
    @@index += 1
    @contacts[contact.id] = contact

    name = "#{contact.last_name}, #{contact.first_name}"
    #set key to value
    @contacts_index[name] = contact.id

  end

  


end


