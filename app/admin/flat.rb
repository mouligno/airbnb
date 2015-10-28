ActiveAdmin.register Flat do
  permit_params :owner_id,
                :title,
                :address_line_1,
                :address_line_2,
                :zip_code,
                :city,
                :country,
                :rooms_number,
                :bed_number,
                :bathroom_number,
                :people_number,
                :smoker,
                :television,
                :internet,
                :kind
  index do
    selectable_column
    column :id
    column :title
    column :city
    column :people_number
    column :kind
    actions
  end

  form do |f|
    inputs 'Flat' do
      f.input :owner, member_label: Proc.new { |user| user.email }
      f.input :title
      f.input :address_line_1
      f.input :address_line_2
      f.input :zip_code
      f.input :city
      f.input :country
      f.input :rooms_number
      f.input :bed_number
      f.input :bathroom_number
      f.input :people_number
      f.input :smoker
      f.input :television
      f.input :internet
      f.input :kind
    end

    actions
  end

  show do
    panel 'Flat' do
      header_action 'Détails'

      attributes_table do
        row :owner_id do
            flat.owner.email
        end

        row :title
        row :kind
        row :rooms_number
        row :bed_number
        row :bathroom_number
        row :people_number
        row :smoker
        row :television
        row :internet
      end
    end

    panel 'Location' do
        attributes_table do
            row :address_line_1
            row :address_line_2
            row :zip_code
            row :city
            row :country
        end
    end

    panel 'Photos' do
      header_action link_to 'Détails', admin_flat_flat_pictures_path(flat)
      # header_action link_to 'Détails', admin_artwork_photos_path(artwork)

      div do
        if flat.flat_pictures.present?
          flat.flat_pictures.each do |flat_picture|
            div do
              image_tag(flat_picture.image.list.url)
            end
          end
        else
          text_node 'Aucune'
        end
      end
    end
  end
end
