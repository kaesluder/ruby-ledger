require 'csv'
require 'date'

# Importer class for getting ledger entries
# from CSV. End product should be a CSV::Table object
class LedgerImporter
  attr_accessor :skip_rows, :header_row

  def initialize(filename)
    @filename = File.expand_path filename

    # values for BOA as of 5/2025
    @skip_rows = 7
    @header_row = 6
  end

  def load_raw
    content = File.read(@filename)
    CSV.parse(content)
  end

  def make_table(rows)
    header = rows[@header_row]
    transactions = rows[@skip_rows..].map { |row| clean_row(CSV::Row.new(header, row)) }
    CSV::Table.new(transactions)
  end

  def clean_row(row)
    row['Amount'] = if row['Amount']
                      row['Amount'].gsub(',', '').to_f
                    elsif row['Running Bal.']
                      row['Running Bal.'].gsub(',', '').to_f
                    else
                      0
                    end

    row['Running Bal.'] = row['Running Bal.'].gsub(',', '').to_f
    row['Date'] = Date.strptime(row['Date'], '%m/%d/%Y')
    row
  end
end
