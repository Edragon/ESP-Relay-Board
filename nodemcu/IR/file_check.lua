function f_read()
    ir_file = "IR_code.txt"
    local ir_data = {}
    local count = 1
    file.open(ir_file)
    while true do 
        line = file.readline()

        if (line == nil) then 
            file.close()
            print ("finish reading IR data file")
            break
        else

            linenos = string.gsub(line, "%s+", "")     
            ir_data[count] = linenos
            count = count +1
        end 
        
        --print(linenos)
    end

    data_pair = {}
    for key, value in ipairs(ir_data) do
        num = string.match(value, "..")
        irdata = string.match(value, "FA..+")
        data_pair[num] = irdata
        --data_pair.cnum = irdata
        --print (data_pair[cnum])
    end
        
    return data_pair
end

function f_write(data_pair)
    file.open(ir_file, "w")
    print ("the line to write: ")
    for key, value in pairs(data_pair) do
        line = key.."_"..value        
        print (line)
        file.writeline(line)
    end
    file.close()
    print ("finish writing")

end


--inkey = "12"

function check_key(inkey)
    data_pair = f_read(file)
    for key, value in pairs(data_pair) do
        --print (key)
        if inkey == key then
            --print ("True")
            return true
        end    
    end  
end

--if check_key(inkey) == true then print ("True") end
