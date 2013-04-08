
local src_dir, build_dir = "./","./"
package.path  = src_dir .. "?.lua;" .. package.path
package.cpath = build_dir .. "?.so;" .. package.cpath

local lz = require("zlib")


local tap   = require("tap")

function test_streaming()
   local shrink     = lz.deflate(lz.BEST_COMPRESSION)
   local enlarge    = lz.inflate(-15)
   local expected   = {}
   local got        = {} 
   local chant      = "Isn't He great, isn't He wonderful?\n"
  
  --[[for i=1,100 do
      if ( i == 100 ) then
         chant = nil
         print "EOF round"
      end
      local shrink_part, shrink_eof   = shrink(chant)
      local enlarge_part, enlarge_eof = enlarge(shrink_part)
      if ( i == 100 ) then
         if not shrink_eof  then error("expected eof after shrinking flush") end
         if not enlarge_eof then error("expected eof after enlarging") end
      else
         if shrink_eof  then error("unexpected eof after shrinking") end
         if enlarge_eof then error("unexpected eof after enlarging") end
      end
      if enlarge_part then table.insert(got, enlarge_part) end
      if chant        then table.insert(expected, chant) end
   end
  tap.ok(table.concat(got) == table.concat(expected), "streaming works")
--]]
  
 local shrink_part,shrink_eof,bytes_in,bytes_out = lz.deflate(9)("aaaaaaaaaa","finish")

--io.write(shrink_part)
 print(string.len(shrink_part),shrink_eof,bytes_in,bytes_out)
	
 local enlarge_part,enlarge_eof,bytes_in,bytes_out = enlarge(shrink_part)

 print((enlarge_part),enlarge_eof,bytes_in,bytes_out)

end


test_streaming()

