ActiveAdmin.register Review do
  permit_params :id, :user_id, :flat_id, :rating, :content

  form do |f|
    inputs 'Review' do
      f.input :user, member_label: Proc.new { |user| user.email }
      f.input :flat
      f.input :rating
      f.input :content
    end

    actions
  end
end
