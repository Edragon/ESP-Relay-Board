
--file = "ir/file_test.txt"

function con_write()
    -- write user and pass
    file.remove("config.txt")
    file.open("config.txt", "w")
    file.writeline("")
    file.writeline("")
    file.close()
end

function write_data()
    --file = "ir/file_test.txt"
    file.open("ir/file_test.txt", "w")
    file.writeline('foo bar')
    file.close()
end

function test1()
file_data = {}
if file.open(file, "r") then
  str = file.readline()
  file.close()
  str2 = string.gsub(str, "%s+", "")
  table.insert(file_data, str2)
  print (file_data)
  
end

end


function lines_from(file)
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

