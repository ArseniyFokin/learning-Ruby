def str_to_float(str)
    begin
        return Float(str)
    rescue => exception
        return nil
    end
end


def str_to_int(str)
    begin
        num = Integer(str)
        if num.to_s == str
            return num
        else
            return nil
        end
    rescue => exception
        return nil
    end
end
