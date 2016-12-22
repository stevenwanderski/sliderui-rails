module AuthHelper
  def login(email, password)
    visit '/auth'
    find('input[name="email"]').set(email)
    find('input[name="password"]').set(password)
    find('button').click

    expect(page).to have_content(email)
  end
end
