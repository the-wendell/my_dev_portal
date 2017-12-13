module CustomValidationsSpec
  def is_valid_css_hex_color(attribute, record)
    it 'is a valid CSS hex color' do
      record.send("#{attribute}=", '#kjhadk')
      record.valid?
      expect(record.errors[attribute]).to eq(['must be a valid CSS hex color code'])

      record.send("#{attribute}=", 123456)
      record.valid?
      expect(record.errors[attribute]).to eq(['must be a valid CSS hex color code'])

      record.send("#{attribute}=", '#123456')
      record.valid?
      expect(record.errors[attribute]).to eq([])
    end
  end
end
