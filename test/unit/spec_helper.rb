require 'chefspec'
require 'chefspec/berkshelf'

# Output code coverage report
at_exit { ChefSpec::Coverage.report! }
