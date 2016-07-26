require "vx/cacher/version"
require "active_support"

module Vx
  module Cacher
    # autoload :Azure, File.expand_path("../cacher/azure", __FILE__)
    autoload :Aws,  File.expand_path("../cacher/aws",  __FILE__)
    autoload :Blob, File.expand_path("../cacher/blob", __FILE__)
  end
end
