require 'oopm/version'

require 'oopm/instructions/natural'
require 'oopm/instructions/integer'
require 'oopm/instructions/real'
require 'oopm/instructions/byte_sequence'

require 'oopm/assembly/instruction'
require 'oopm/assembly/literal'
require 'oopm/assembly/reference'
require 'oopm/assembly/send_msg'

require 'treetop'
require 'oopm/parsing/node_type'
require 'oopm/parsing/keyword'
require 'oopm/parsing/reference'
require 'oopm/parsing/reference_node'
require 'oopm/parsing/literal'
require 'oopm/parsing/literal_node'
require 'oopm/parsing/container'
require 'oopm/parsing/container_nodes'
require 'oopm/parsing/expression'
require 'oopm/parsing/expression_nodes'

require 'oopm/util/unique_name'

require 'oopm/processing/bytecode_processor'
