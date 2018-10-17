module HomeHelper
  def home_buttons
    if !signed_in?
      content_tag :div, class: 'button-groups' do
        concat(content_tag(:a, href: new_patient_session_url) do
          content_tag :button, 'Login', class: 'home-buttons',
                                        id: 'first-button'
        end)
        concat(content_tag(:a, href: new_patient_registration_url) do
          content_tag :button, 'Signup',
                      class: 'home-buttons', id: 'second-button'
        end)
      end
    else
      signed_in_links
    end
  end

  def signed_in_links
    if !current_doctor.nil?
      doctor_home_links
    elsif !current_patient.nil?
      patient_home_links
    end
  end
end

def patient_home_links
  content_tag :div, class: 'button-groups' do
    concat(content_tag(:a, href: new_appointment_url) do
      content_tag :button, 'Make an appointment', class: 'home-buttons',
                                                  id: 'first-button'
    end)
    concat(content_tag(:a, href: '#') do
      content_tag :button, 'View appointment history',
                  class: 'home-buttons', id: 'second-button'
    end)
  end
end

def doctor_home_links
  content_tag :div, class: 'button-groups' do
    content_tag(:a, href: '#') do
      content_tag :button, 'View appointment history', class: 'home-buttons',
                                                       id: 'first-button'
    end
  end
end
