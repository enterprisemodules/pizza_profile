#   pizza_profile::kid_pizza { 'namevar': }
define pizza_profile::kid_pizza (
  Integer[0,18] $age   = 12,
  String[1]     $dough = 'white',   # Most kids don't like wholesome
  String[1]     $cheese = 'mozzarella',
) {
  if $age < 2 {
    fail "probably not wise to order a pizza for a kid of ${age}."
  } elsif $age < 5 {
    $size = 10
    $amount_of_tomato_souce = 4
    $amount_of_cheese = 4
  } elsif $age < 8 {
    $size = 20
    $amount_of_tomato_souce = 5
    $amount_of_cheese = 5
  } else {
    $size = 30
    $amount_of_tomato_souce = 6
    $amount_of_cheese = 5
  }

  crust { "${title}/medium_wholesome_thin_crust":
    ensure => baked,
    size   => $size,
    type   => 'thin',       # thin
    dough  => 'wholesome', # wholesome ore white
  }

  -> tomato_sauce { "${title}/thick_cristal":
    ensure    => 'present',
    type      => 'cristal',
    composure => 'thick',
    amount    => $amount_of_tomato_souce,
  }
  -> cheese { "${title}/a_lot_of_mozzarella":
    ensure => 'present',
    type   => $cheese,
    amount => $amount_of_cheese,
  }
}
