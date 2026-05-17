const { greet } = require("./utils");

function main() {
  const name = process.argv[2] || "world";
  console.log(greet(name));
}

main();
