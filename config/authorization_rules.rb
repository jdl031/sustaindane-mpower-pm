authorization do
	role :admin do
		has_permission_on :companies, :to => [:index, :create, :new, :read, :edit, :show, :save, :destroy, :update]
		has_permission_on :projects, :to => [:index, :create, :new, :read, :edit, :show, :save, :destroy, :update]
		has_permission_on :tasks, :to => [:index, :create, :new, :read, :edit, :show, :save, :destroy, :update]
		has_permission_on :comments, :to => [:index, :create, :new, :read, :edit, :show, :save, :destroy, :update]
		has_permission_on :registrations, :to => [:new, :create]
	end

	role :company_admin do
		has_permission_on :companies, :to => [:index]
		has_permission_on :companies, :to => [:read, :show] do
			if_attribute :id => is { user.company_id }
		end

		has_permission_on :projects, :to => [:index, :create, :new]
		has_permission_on :projects, :to => [:read, :edit, :update, :show, :save, :destroy] do   # @todo: can users create tasks??
			if_attribute :company_id => is { user.company_id }
		end

		has_permission_on :tasks, :to => [:index, :create, :new]
		has_permission_on :tasks, :to => [:read, :edit, :update, :show, :save, :destroy] do   # @todo: can users create tasks??
			if_attribute :project => { :company_id => is { user.company_id } }
		end

		has_permission_on :comments, :to => [:index, :create, :new]
		has_permission_on :comments, :to => [:read, :edit, :update, :show, :save, :destroy] do
			if_attribute :task => { :project => { :company_id => is { user.company_id } } }
		end

		has_permission_on :registrations, :to => [:new, :create]
	end

	role :user do
		has_permission_on :companies, :to => [:index]
		has_permission_on :companies, :to => [:read, :show] do
			if_attribute :id => is { user.company_id }
		end

		has_permission_on :projects, :to => [:index]
		has_permission_on :projects, :to => [:read, :edit, :update, :show, :save] do
			if_attribute :company_id => is { user.company_id }
		end

		has_permission_on :tasks, :to => [:index, :create, :new]
		has_permission_on :tasks, :to => [:read, :edit, :update, :show, :save] do
			if_attribute :project => { :company_id => is { user.company_id } }
		end

		has_permission_on :comments, :to => [:index, :create, :new]
		has_permission_on :comments, :to => [:read, :edit, :update, :show, :save, :destroy] do
			if_attribute :task => { :project => { :company_id => is { user.company_id } } }
		end
	end
end
