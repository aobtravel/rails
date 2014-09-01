require 'spec_helper'

describe TranslationIO::FlatHash do

  describe '#to_flat_hash' do
    it 'returns a flat hash' do
      hash = {
        'en' => {
          'hello' => 'Hello world',
          'main'  => {
            'menu' => {
              'stuff' => 'This is stuff'
            }
          },
          'bye' => 'Good bye world',

          'bidules' => [
            'bidule 1',
            'bidule 2'
          ],

          'buzzwords' => [
            ['Adaptive', 'Advanced' ],
            ['24 hour', '4th generation']
          ],

          'age' => 42,

          :address => 'Cour du Curé',

          'names' => [
            { 'first' => 'Aurélien', 'last' => 'Malisart' },
            { 'first' => 'Michaël',  'last' => 'Hoste'    }
          ]
        }
      }

      flat_hash = subject.to_flat_hash(hash)

      flat_hash.should == {
        'en.hello'           => 'Hello world'   ,
        'en.main.menu.stuff' => 'This is stuff' ,
        'en.bye'             => 'Good bye world',
        'en.bidules[0]'      => 'bidule 1',
        'en.bidules[1]'      => 'bidule 2',
        'en.buzzwords[0][0]' => 'Adaptive',
        'en.buzzwords[0][1]' => 'Advanced',
        'en.buzzwords[1][0]' => '24 hour',
        'en.buzzwords[1][1]' => '4th generation',
        'en.age'             => 42,
        'en.address'         => 'Cour du Curé',
        'en.names[0].first'  => 'Aurélien',
        'en.names[0].last'   => 'Malisart',
        'en.names[1].first'  => 'Michaël',
        'en.names[1].last'   => 'Hoste'
      }
    end

    it 'returns a flat hash with nil values' do
      hash = {
        "en" => {
          "date" => {
            "formats" => {
              "default" => "%Y-%m-%d",
              "long"    => "%B %d, %Y",
              "short"   =>"%b %d"
            },
            "abbr_day_names"   => [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ],
            "abbr_month_names" => [ nil, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
            "day_names"        => [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ]
          }
        }
      }

      flat_hash = subject.to_flat_hash(hash)

      flat_hash.should == {
        "en.date.formats.default"      => "%Y-%m-%d",
        "en.date.formats.long"         => "%B %d, %Y",
        "en.date.formats.short"        => "%b %d",
        "en.date.abbr_day_names[0]"    => "Sun",
        "en.date.abbr_day_names[1]"    => "Mon",
        "en.date.abbr_day_names[2]"    => "Tue",
        "en.date.abbr_day_names[3]"    => "Wed",
        "en.date.abbr_day_names[4]"    => "Thu",
        "en.date.abbr_day_names[5]"    => "Fri",
        "en.date.abbr_day_names[6]"    => "Sat",
        "en.date.abbr_month_names[0]"  => nil,
        "en.date.abbr_month_names[1]"  => "Jan",
        "en.date.abbr_month_names[2]"  => "Feb",
        "en.date.abbr_month_names[3]"  => "Mar",
        "en.date.abbr_month_names[4]"  => "Apr",
        "en.date.abbr_month_names[5]"  => "May",
        "en.date.abbr_month_names[6]"  => "Jun",
        "en.date.abbr_month_names[7]"  => "Jul",
        "en.date.abbr_month_names[8]"  => "Aug",
        "en.date.abbr_month_names[9]"  => "Sep",
        "en.date.abbr_month_names[10]" => "Oct",
        "en.date.abbr_month_names[11]" => "Nov",
        "en.date.abbr_month_names[12]" => "Dec",
        "en.date.day_names[0]"         => "Sunday",
        "en.date.day_names[1]"         => "Monday",
        "en.date.day_names[2]"         => "Tuesday",
        "en.date.day_names[3]"         => "Wednesday",
        "en.date.day_names[4]"         => "Thursday",
        "en.date.day_names[5]"         => "Friday",
        "en.date.day_names[6]"         => "Saturday"
      }

      subject.to_hash(flat_hash).should == hash
    end

    it 'returns another flash hash with nil values' do
      hash =  {
        "nl" => {
          "date" => {
            "abbr_day_names"   => [ "zon", "maa", "din", "woe", "don", "vri", "zat" ],
            "abbr_month_names" => [ nil, "jan", "feb", "mar", "apr", "mei", "jun", "jul", "aug", "sep", "okt", "nov", "dec" ],
            "day_names"        => [ "zondag", "maandag", "dinsdag", "woensdag", "donderdag", "vrijdag", "zaterdag" ],
            "formats" => {
              "default" => "%d/%m/%Y",
              "long"    => "%e %B %Y",
              "short"   => "%e %b"
            }
          }
        }
      }

      flat_hash = subject.to_flat_hash(hash)

      flat_hash.should == {
        "nl.date.abbr_day_names[0]"    => "zon",
        "nl.date.abbr_day_names[1]"    => "maa",
        "nl.date.abbr_day_names[2]"    => "din",
        "nl.date.abbr_day_names[3]"    => "woe",
        "nl.date.abbr_day_names[4]"    => "don",
        "nl.date.abbr_day_names[5]"    => "vri",
        "nl.date.abbr_day_names[6]"    => "zat",
        "nl.date.abbr_month_names[0]"  => nil,
        "nl.date.abbr_month_names[1]"  => "jan",
        "nl.date.abbr_month_names[2]"  => "feb",
        "nl.date.abbr_month_names[3]"  => "mar",
        "nl.date.abbr_month_names[4]"  => "apr",
        "nl.date.abbr_month_names[5]"  => "mei",
        "nl.date.abbr_month_names[6]"  => "jun",
        "nl.date.abbr_month_names[7]"  => "jul",
        "nl.date.abbr_month_names[8]"  => "aug",
        "nl.date.abbr_month_names[9]"  => "sep",
        "nl.date.abbr_month_names[10]" => "okt",
        "nl.date.abbr_month_names[11]" => "nov",
        "nl.date.abbr_month_names[12]" => "dec",
        "nl.date.day_names[0]"         => "zondag",
        "nl.date.day_names[1]"         => "maandag",
        "nl.date.day_names[2]"         => "dinsdag",
        "nl.date.day_names[3]"         => "woensdag",
        "nl.date.day_names[4]"         => "donderdag",
        "nl.date.day_names[5]"         => "vrijdag",
        "nl.date.day_names[6]"         => "zaterdag",
        "nl.date.formats.default"      => "%d/%m/%Y",
        "nl.date.formats.long"         => "%e %B %Y",
        "nl.date.formats.short"        => "%e %b"
      }

      subject.to_hash(flat_hash).should == hash
    end
  end

  describe '#to_hash' do
    it 'returns a simple hash' do
      flat_hash = {
        'en' => 'hello'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == { 'en' => 'hello' }
    end

    it 'returns a simple array' do
      flat_hash = {
        'en[0]' => 'hello'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == { 'en' => ['hello'] }
    end

    it 'returns a simple array with 2 elements' do
      flat_hash = {
        'en[0]' => 'hello',
        'en[1]' => 'world'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == { 'en' => ['hello', 'world'] }
    end


    it 'returns a double array' do
      flat_hash = {
        'en[0][0]' => 'hello',
        'en[0][1]' => 'world'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == { 'en' => [['hello', 'world']] }
    end

    it 'returns a double array with hash in it' do
      flat_hash = {
        'en[0][0].hello'    => 'hello world',
        'en[0][1].goodbye'  => 'goodbye world',
        'en[1][0].hello2'   => 'hello lord',
        'en[1][1].goodbye2' => 'goodbye lord'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == {
        'en' => [
          [
            { 'hello'   => 'hello world'   },
            { 'goodbye' => 'goodbye world' }
          ],
          [
            { 'hello2'   => 'hello lord'   },
            { 'goodbye2' => 'goodbye lord' }
          ]
        ]
      }
    end

    it 'return a hash with arrays at many places' do
      flat_hash = {
        'fr[0][0].bouh.salut[0]'  => 'blabla',
        'fr[0][0].bouh.salut[1]'  => 'blibli',
        'fr[1][0].salut'          => 'hahah',
        'fr[1][1].ha'             => 'house'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == {
        'fr' => [
          [{
            'bouh' => {
              'salut' => [ 'blabla', 'blibli' ]
            }
          }],
          [
            { 'salut' => 'hahah' },
            { 'ha'    => 'house'}
          ]
        ]
      }
    end

    it 'returns a hash' do
      flat_hash = {
        'en.hello'              => 'Hello world'   ,
        'en.main.menu[0].stuff' => 'This is stuff' ,
        'en.bye'                => 'Good bye world',
        'en.bidules[0]'         => 'bidule 1',
        'en.bidules[1]'         => 'bidule 2',
        'en.family[0][0]'       => 'Ta mère',
        'en.family[0][1]'       => 'Ta soeur',
        'en.family[1][0]'       => 'Ton père',
        'en.family[1][1]'       => 'Ton frère'
      }

      hash = subject.to_hash(flat_hash)

      hash.should == {
        'en' => {
          'hello' => 'Hello world',
          'main'  => {
            'menu' => [
              'stuff' => 'This is stuff'
            ]
          },
          'bye' => 'Good bye world',

          'bidules' => [
            'bidule 1',
            'bidule 2'
          ],

          'family' => [
            ['Ta mère', 'Ta soeur'],
            ['Ton père', 'Ton frère'],
          ]
        }
      }
    end
  end

  it 'returns a hash with missing array values' do
    flat_hash = {
      "nl.date.abbr_month_names[1]"  => "jan",
      "nl.date.abbr_month_names[2]"  => "feb",
      "nl.date.abbr_month_names[3]"  => "mar"
    }

    hash = subject.to_hash(flat_hash)

    hash.should == {
      'nl' => {
        'date' => {
          'abbr_month_names' => [nil, 'jan', 'feb', 'mar']
        }
      }
    }
  end

  it 'handles empty/nil keys' do
    flat_hash = {
      ""  => "jan"
    }

    hash = subject.to_hash(flat_hash)

    hash.should == {
      nil => "jan"
    }
  end
end
