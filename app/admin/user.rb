ActiveAdmin.register User do
  permit_params :id, :email, :admin, :created_at, :updated_at, :confirmed_at

  index do
    selectable_column
    column :id
    column :email
    column :created_at
    column :updated_at
    column :sign_in_count
    column :confirmed_at
    actions
  end
end
