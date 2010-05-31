#
# Ninja ASM adds some sneaky macros to your ASM
# Usage: ruby ninja_asm.rb mycode.ninja.asm
#

if ARGV.size != 1
  puts "Usage: ruby ninja_asm.rb mycode.ninja.asm"
  exit
end

input = IO.read(ARGV[0])
output = ""

macro_map = {}

cur = 0
while cur <= input.size
  idx = input.index("{", cur)
  if idx
    # macro found
    output += input[cur, idx-cur]
    cur = idx + 1

    idx2 = input.index("}", cur)
    if idx2
      # end of macro found => full macro command available
      macro = input[cur, idx2-cur]
      cur = idx2 + 1
      eidx = macro.index("=")
      if eidx
        # Assign macro
        name = macro[0, eidx]
        value = macro[(eidx + 1)..-1]
        value.sub!("\n  ", "")
        macro_map[name] = value
      else
        # Print out macro
        if !macro_map[macro]
          raise "Macro '#{macro}' not found. Ninja is confused."
        end
        output += macro_map[macro]
      end
    else
      raise "Expected end of Macro '}'. Ninja is stuck."
    end
  else
    # no more macros so read to end of file
    output += input[cur..-1] || ""
    break
  end
end

puts output
