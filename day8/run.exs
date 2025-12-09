Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part1.ex", __DIR__)
Code.require_file("./lib/part2.ex", __DIR__)

IO.puts("All code files required as expected")

"./test.txt"
|> Parser.parse()
|> Part1.solve(10)
|> IO.inspect(label: "Part 1 Test")

"./input.txt"
|> Parser.parse()
|> Part1.solve(1000)
|> IO.inspect(label: "Part 1 Solve")

"./test.txt"
|> Parser.parse()
|> Part2.solve()
|> IO.inspect(label: "Part 2 Test")

"./input.txt"
|> Parser.parse()
|> Part2.solve()
|> IO.inspect(label: "Part 2 Solve")
