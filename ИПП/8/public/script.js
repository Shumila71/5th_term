function updateOutput(message) {
  document.getElementById("output").textContent = message;
}

async function register() {
  const id = document.getElementById("register-id").value;
  const username = document.getElementById("register-username").value;
  const password = document.getElementById("register-password").value;

  const response = await fetch("/register", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id, username, password }),
  });
  const result = await response.json();
  updateOutput(JSON.stringify(result, null, 2));
}

async function login() {
  const username = document.getElementById("login-username").value;
  const password = document.getElementById("login-password").value;

  const response = await fetch("/login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ username, password }),
  });
  const result = await response.json();
  updateOutput(JSON.stringify(result, null, 2));
}

async function update() {
  const id = document.getElementById("update-id").value;
  const username = document.getElementById("update-username").value;
  const password = document.getElementById("update-password").value;

  const response = await fetch("/update", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id, username, password }),
  });
  const result = await response.json();
  updateOutput(JSON.stringify(result, null, 2));
}
