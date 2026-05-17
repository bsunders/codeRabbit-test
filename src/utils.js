function greet(name) {
  if (!name || typeof name !== "string") {
    return "Hello, world!";
  }
  return `Hello, ${name.trim()}!`;
}

module.exports = { greet };
