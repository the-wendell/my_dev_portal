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

  def project_attribute_has_maximum_length_of(length, attribute)
    let(:user) { FactoryGirl.create(:user) }
    let(:portfolio) { FactoryGirl.create(:portfolio, user: user) }
    let(:attribute) do
      { header_one: 'testing title',
        header_two: 'exiting stuff',
        header_two_color: '#ffffff',
        header_one_color: '#ffffff',
        portfolio_id: portfolio.id }
    end

    short_string = build_string(length)
    long_string = build_string(length + 1)

    it "has a maximum length of #{length}" do
      record = portfolio.projects.new(project_input)
      record.send("#{attribute}=", short_string)
      record.valid?
      expect(record.errors[attribute]).to eq([])
      record.send("#{attribute}=", long_string)
      record.valid?
      expect(record.errors[attribute].length).to eq(1)
    end
  end

  def build_string(length)
    string = ''
    length.times do
      string << 'a'
    end
    string
  end
end
