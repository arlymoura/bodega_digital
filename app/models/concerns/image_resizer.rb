# frozen_string_literal: true

module ImageResizer
  extend ActiveSupport::Concern

  def resize_and_store_imagens(field_name: :imagens, max_dimensions: [1920, 1080], quality: 85)
    attachments = send(field_name)

    return unless attachments.attached?

    # Garante que seja tratado como uma coleção
    attachments = [attachments] unless attachments.is_a?(Enumerable)

    attachments.each do |attachment|
      begin
        # Verifica se o arquivo está disponível e pode ser baixado
        file = attachment.download
      rescue ActiveStorage::FileNotFoundError => e
        Rails.logger.error "File not found for #{field_name}: #{e.message}"
        next # Passa para o próximo arquivo em caso de erro
      end

      original_filename = attachment.filename.to_s
      file_extension = File.extname(original_filename)
      unique_filename = "#{SecureRandom.uuid}#{file_extension}"

      # Carrega e redimensiona a imagem
      image = MiniMagick::Image.read(file)
      image.resize "#{max_dimensions[0]}x#{max_dimensions[1]}"
      image.quality(quality)
      image.strip

      # Remove o arquivo original e substitui pelo redimensionado
      attachment.purge

      # Anexa a nova imagem redimensionada
      send(field_name).attach(
        io: StringIO.new(image.to_blob),
        filename: unique_filename,
        content_type: attachment.blob.content_type
      )
    end
  end
end
