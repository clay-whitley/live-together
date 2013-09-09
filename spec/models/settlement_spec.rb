require 'spec_helper'

describe Settlement do

  describe "validations" do
    it { should validate_presence_of :amount_cents }
    it { should validate_presence_of :date_paid }
    it { should belong_to :user }
    it { should belong_to :grocery_list }
    it { should belong_to :expense }
  end

end
