res = [1, 2, 3, 4].map do |num|
  num.to_s
end

pp res

res_two = [1, 2, 3, 4].map(&:to_s)

pp res

to_s_proc = :to_s.to_proc
pp to_s_proc.call(56)


h = {a:1, b:2}
hash_proc = h.to_proc
pp hash_proc.call(:a)