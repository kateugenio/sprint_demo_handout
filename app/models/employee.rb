class Employee < ApplicationRecord
  belongs_to :role
  
  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  with_options if: :tpo? do |role|
    role.validate :prevent_duplicate_tpo
  end
  with_options if: :sm? do |role|
    role.validate :prevent_duplicate_sm
  end

  def tpo?
    role_id == 2
  end

  def sm?
    role_id == 3
  end

  private

  def prevent_duplicate_tpo
    if Employee.where(role_id: '2').exists?
      errors[:base] << "Team Product Owner already exists. Please change the role or remove the current Team Product Owner to add new team member."
    end
  end

  def prevent_duplicate_sm
    if Employee.where(role_id: '3').exists?
      errors[:base] << "Scrum Master already exists. Please change the role or remove the current Scrum Master to add new team member."
    end
  end

end
