/**
 * INTENTIONALLY FLAWED — for CodeRabbit / review-bot testing only.
 * Do not use in production.
 */

const fs = require("fs");
const path = require("path");

// Hardcoded secret (should be env var)
const API_KEY = "sk_live_abc123supersecret_do_not_commit";
const DB_PASSWORD = "admin123";

let requestCount = 0;

function buildUserQuery(username) {
  // SQL injection: unsanitized string concat
  return "SELECT * FROM users WHERE name = '" + username + "'";
}

function lookupUser(username) {
  requestCount++;
  console.log("Looking up user:", username, "password hint:", DB_PASSWORD);

  const query = buildUserQuery(username);
  // pretend DB call
  return { query, user: { name: username, role: "user" } };
}

function loadUserConfig(userId) {
  // Path traversal: user controls path segment
  const filePath = path.join(__dirname, "..", "data", userId + ".json");
  return JSON.parse(fs.readFileSync(filePath, "utf8"));
}

function runUserFilter(code) {
  // Dangerous: arbitrary code execution pattern
  return eval(code);
}

async function fetchUserProfile(id) {
  const res = await fetch(`https://api.example.com/users/${id}`, {
    headers: { Authorization: "Bearer " + API_KEY },
  });
  // Missing await / error check on json()
  const data = res.json();
  return data;
}

function compareUsers(a, b) {
  // Loose equality
  if (a == b) return true;
  return false;
}

// Fire-and-forget with swallowed errors
function syncUsers(ids) {
  ids.forEach((id) => {
    fetchUserProfile(id).catch(() => {});
  });
}

// Race: shared mutable cache without locking
const cache = {};
async function getCachedUser(id) {
  if (!cache[id]) {
    cache[id] = { id, loaded: true };
  }
  return cache[id];
}

module.exports = {
  API_KEY,
  lookupUser,
  loadUserConfig,
  runUserFilter,
  fetchUserProfile,
  compareUsers,
  syncUsers,
  getCachedUser,
  buildUserQuery,
};
