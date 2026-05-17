const { describe, it } = require("node:test");
const assert = require("node:assert");
const { greet } = require("../src/utils");

describe("greet", () => {
  it("returns hello for a name", () => {
    assert.strictEqual(greet("Ada"), "Hello, Ada!");
  });
});
