# lib/barcode_generator.rb
class BarcodeGenerator
  def self.generate_ean13
    country_code = "789" # Exemplo do Brasil
    manufacturer_code = "12345" # Seu código de fabricante
    product_code = SecureRandom.hex(6).to_s

    # Concatena os códigos para formar os 12 primeiros dígitos
    base = "#{country_code}#{manufacturer_code}#{product_code}"

    # Calcula o dígito verificador (método baseado no algoritmo de módulo 10)
    check_digit = calculate_check_digit(base)

    # Retorna o código EAN-13 completo
    "#{base}#{check_digit}"
  end

  def self.calculate_check_digit(base)
    digits = base.chars.map(&:to_i)
    odd_sum = digits.values_at(*digits.each_index.select(&:even?)).sum
    even_sum = digits.values_at(*digits.each_index.select(&:odd?)).sum
    (10 - ((odd_sum + (even_sum * 3)) % 10)) % 10
  end
end
