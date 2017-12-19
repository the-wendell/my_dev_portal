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

  def is_valid_url(attribute, record)
    it 'is a valid URL' do
      record.send("#{attribute}=", 'kjhadk')
      record.valid?
      expect(record.errors[attribute]).to eq(["must be a valid URL (URLs must start with 'http://')"])

      record.send("#{attribute}=", 'www.facebook.com')
      record.valid?
      expect(record.errors[attribute]).to eq(["must be a valid URL (URLs must start with 'http://')"])

      record.send("#{attribute}=", 'http://www.facebook.com')
      record.valid?
      expect(record.errors[attribute]).to eq([])
    end
  end
end
