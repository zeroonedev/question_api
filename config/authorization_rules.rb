authorization do

  role :admin do
    has_permission_on [:users, :questions, :episodes], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :producer do
    has_permission_on [:users, :questions, :episodes], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :writer do
    has_permission_on [:questions], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

end