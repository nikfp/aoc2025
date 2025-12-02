Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part1.ex", __DIR__)
Code.require_file("./lib/part2.ex", __DIR__)

IO.puts("All code files required as expected")

"./test.txt"
|> Parser.parse()
|> Part1.solve()
|> IO.inspect(label: "Part 1 test")

"./input.txt"
|> Parser.parse()
|> Part1.solve()
|> IO.inspect(label: "Part 1 prod")

"./test.txt"
|> Parser.parse()
|> Part2.solve()
|> IO.inspect(label: "Part 2 test")

"./input.txt"
|> Parser.parse()
|> Part2.solve()
|> IO.inspect(label: "Part 2 prod")
