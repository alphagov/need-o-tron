module DeviseMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.new
      sign_in @user
    end
  end
end
