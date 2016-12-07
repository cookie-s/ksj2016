kadai = ARGV.shift || exit(0)

files = `ls #{kadai}/*`.split("\n")
filenames = files.map{ |filepath| filepath[filepath.rindex('/')+1,filepath.size]}

puts "%s という%d個のファイルを置いた。以下にそれぞれ内容を示す。"%[ filenames.join(', '), files.size]

puts

puts (files.map do |filepath|
  filename = filepath[filepath.rindex('/')+1,filepath.size]
  "``` %s\n%s\n```\n"%[filename, `cat #{filepath}`]
end.join("\n"))

puts
puts

puts 'これらのファイルをアーカイブ化して圧縮、base64化したものが以下。'
puts 'base64 -d | tar zxに標準入力から以下を与えることで解凍される。'

puts

puts `tar zc #{kadai} | base64`
