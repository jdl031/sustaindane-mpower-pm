class RegistrationsController < Devise::RegistrationsController
  filter_access_to :all
  prepend_before_filter :require_no_authentication, :only => [:cancel]
  prepend_before_filter :authenticate_scope!, :only => [:create, :new, :edit, :update, :destroy]

	def new
		super
	end

	def create
    build_resource

    if current_user.role.name == 'company_admin'
      if resource.role.name != 'company_admin'
        resource.role = Role.find_by_name('user')
      end
      puts 'company_admin', current_user.company_id
      resource.company_id = current_user.company_id
    end

    puts 'resource.company_id', resource.company_id

    # random 'unguessable' password
    password = SecureRandom.hex(20)
    resource.password = password
    resource.password_confirmation = password

    if resource.save
    	resource_class.send_reset_password_instructions(resource_params)
      set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
      expire_session_data_after_sign_in!
      respond_with resource, :location => after_inactive_sign_up_path_for(resource)
    else
      respond_with resource
    end
	end

  def edit
    super
  end
end
