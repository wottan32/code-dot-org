class UserSchoolInfosController < ApplicationController
  # Questions
  # Is my syntax correct?
  #


  # PATCH /api/v1/users_school_infos/<id>/update_last_confirmation_date
  def update_last_confirmation_date
    user_school_info = UserSchoolInfo.find(params[:id])
    result = user_school_info.update ({
      last_confirmation_date: DateTime.now
    })
    if result
      head :no_content
    else
      render json: user_school_info.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/users_school_infos/<id>/update_end_date_last_seen_school_info_interstitial
  def update_end_date_last_seen_school_info_interstitial
    user_school_info = UserSchoolInfo.find(params[:id])

    # approach 1
    user_school_info.update!(end_date: DateTime.now)

    # approach 2
    user_school_info.update_foo

    head :no_content
  end

  # note name of method used in component
  # POST /api/v1/users_school_infos/<id>/update_school_info_id
  def update_school_info_history

    ActiveRecord::Base.transaction do
      if params[:add_new_school] == 1
        school = School.create(new_school_params)
        school.school_infos.create(school_info_params)
      else
        school = School.find(params[:school_id])
      end

      school_info = school.school_infos.order(created_at: :desc).first

      # ALWAYS create a new user_schoo_info row
      current_user.user_school_infos.create(user_school_info_params)

      # Update the user(current_user) with the school_info_id
      current_user.update school_info_id: school_info.id
    end


    ###################
    user.user_school_infos.where(school_info_id: user.school_info_id).first_or_create!(
        start_date: user.created_at,
        last_confirmation_date: user.last_seen_school_info_interstitial.nil? ? user.created_at : user.last_seen_school_info_interstitial
      )

    user_school_info.update(school_info_id: )

    current_user.update(school_info_id: )
  end

  private

  def new_school_params
    params.require(:)
  end

end
