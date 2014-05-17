require 'do_by'

describe DoBy::Note do
  before do
    allow(Time).to receive(:now) { DateTime.parse('2014-06-01 18:30') }
  end

  it "is happy with a note without a date" do
    expect { DoBy::Note.new('foo') }.to_not raise_error
  end

  it "is happy with a date in the future" do
    expect { DoBy::Note.new('foo', '2014-06-01 19:00') }.to_not raise_error
  end

  it "is not happy with a date in the past" do
    expect { DoBy::Note.new('foo', '2014-06-01 18:00') }.
      to raise_error(DoBy::LateTask, "foo is overdue (2014-06-01 18:00)")
  end

  it "supports a DSL" do
    expect(DoBy::Note).to receive(:new).with('fix this', '2012-01-01')
    TODO 'fix this', '2012-01-01'
  end
end