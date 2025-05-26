require_relative '../lib/ledger_import'

RSpec.describe LedgerImporter do
  context 'basic file loading' do
    it 'loads a raw csv file' do
      filename = './spec/stmt.csv'
      importer = LedgerImporter.new filename
      raw_csv = importer.load_raw
      expect(raw_csv.length).to eq(11)
    end
  end

  context 'Column Types' do
    let(:importer) { LedgerImporter.new('./spec/stmt.csv') }
    let(:table) { importer.make_table(importer.load_raw) }

    it 'has Amount as a Float' do
      expect(table[0]['Amount'].instance_of?(Float)).to be true
    end

    it 'has Running Bal. as a Float' do
      expect(table[0]['Running Bal.'].instance_of?(Float)).to be true
    end

    it 'has Date as a Date' do
      expect(table[0]['Date'].instance_of?(Date)).to be true
    end
  end

  context 'Table Values' do
    let(:importer) { LedgerImporter.new('./spec/stmt.csv') }
    let(:table) { importer.make_table(importer.load_raw) }

    it 'has the correct Amount' do
      expect(table[0]['Amount']).to eq(1932.00)
    end

    it 'has the correct Date' do
      expect(table[0]['Date']).to eq(Date.new(2025, 5, 23))
      puts(table)
    end
  end
end
