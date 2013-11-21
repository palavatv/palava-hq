Fabricator(:potential) do
  email "someone@palava.tv"
end

Fabricator(:confirmed_potential, from: :potential) do
  confirmed true
end

Fabricator(:potential_with_invalid_email, class_name: 'Potential') do
  email "uitrnetdriu"
end
