ActiveAdmin.register BookingRequest do
  permit_params :id,
                :flat_id,
                :requester_id,
                :start_date,
                :end_date,
                :description,
                :status

  form do |f|
    inputs 'Booking request' do
      f.input :flat
      f.input :requester, member_label: Proc.new { |user| user.email }
      f.input :start_date
      f.input :end_date
      f.input :description
      f.input :status
    end

    actions
  end
end
