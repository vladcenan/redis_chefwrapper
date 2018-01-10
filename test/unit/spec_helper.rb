require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/coveragereports'

# Output code coverage report
ChefSpec::CoverageReports.add('json', '.coverage/results.json')
at_exit { ChefSpec::Coverage.report! }
