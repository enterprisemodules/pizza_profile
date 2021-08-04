# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'a kid pizza' do
  it { is_expected.to compile }

  it { is_expected.to contain_class('Settings')
  }
  
  it { is_expected.to contain_pizza_profile__kid_pizza('namevar')
    .with('dough'  => 'white')
    .with('cheese' => 'mozzarella')
  }
  
  it { is_expected.to contain_crust('namevar/medium_wholesome_thin_crust')
    .with('ensure' => 'baked')
    .with('type'   => 'thin')
    .with('dough'  => 'wholesome')
    .that_comes_before('Tomato_sauce[namevar/thick_cristal]')
  }
  
  it { is_expected.to contain_tomato_sauce('namevar/thick_cristal')
    .with('ensure'    => 'present')
    .with('type'      => 'cristal')
    .with('composure' => 'thick')
    .that_comes_before('Cheese[namevar/a_lot_of_mozzarella]')
  }
  
  it { is_expected.to contain_cheese('namevar/a_lot_of_mozzarella')
    .with('ensure' => 'present')
    .with('type'   => 'mozzarella')
  }
end

describe 'pizza_profile::kid_pizza' do
  let(:title) { 'namevar' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'kids younger then 2' do
        let(:params) do
          { :age => 1 }
        end
        it { is_expected.to compile.and_raise_error(/probably not wise to order a pizza for a kid of 1./) }
      end

      context 'kids between 2 and 5' do
        let(:params) do
          { :age => 3 }
        end

        it_behaves_like 'a kid pizza'

        it { is_expected.to contain_crust('namevar/medium_wholesome_thin_crust')
          .with('size'   => '10')
        }
        
        it { is_expected.to contain_tomato_sauce('namevar/thick_cristal')
          .with('amount'    => '4')
        }
        
        it { is_expected.to contain_cheese('namevar/a_lot_of_mozzarella')
          .with('amount' => '4')
        }
      end

      context 'kids between 5 and 8' do
        let(:params) do
          { :age => 7 }
        end

        it_behaves_like 'a kid pizza'

        it { is_expected.to contain_crust('namevar/medium_wholesome_thin_crust')
          .with('size'   => '20')
        }
        
        it { is_expected.to contain_tomato_sauce('namevar/thick_cristal')
          .with('amount'    => '5')
        }
        
        it { is_expected.to contain_cheese('namevar/a_lot_of_mozzarella')
          .with('amount' => '5')
        }
      end

      context 'kids older then 8 (default case)' do
        let(:params) do
          {}
        end

        it_behaves_like 'a kid pizza'
        
        it { is_expected.to contain_crust('namevar/medium_wholesome_thin_crust')
          .with('size'   => '30')
        }
        
        it { is_expected.to contain_tomato_sauce('namevar/thick_cristal')
          .with('amount'    => '6')
        }
        
        it { is_expected.to contain_cheese('namevar/a_lot_of_mozzarella')
          .with('amount' => '5')
        }
      end
    end
  end
end
