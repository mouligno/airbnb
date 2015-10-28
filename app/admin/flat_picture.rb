ActiveAdmin.register FlatPicture do
  belongs_to :flat

  navigation_menu :flat

  permit_params :image

  index do
    id_column

    column :image do |flat_picture|
      if flat_picture.image
        image_tag(flat_picture.image.small.url)
      end
    end

    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :image do
        if flat_picture.image
          image_tag(flat_picture.image.small.url)
        else
          text_node 'Aucun fichier'
        end
      end

      row :created_at
      row :updated_at
    end
  end
end
