// Customer support form behaviour
const supportForm = document.getElementById("support-form");
const supportResponse = document.getElementById("support-response");

supportForm.addEventListener("submit", (event) => {
  event.preventDefault();

  const product = document.getElementById("product");
  const question = document.getElementById("question").value.trim();

  if (!product.value || !question) {
    supportResponse.textContent = "Please select a product and enter your question.";
    return;
  }

  const productName = product.options[product.selectedIndex].text;

  supportResponse.textContent =
    `Your question about ${productName} is ready. AI-powered support will become available once our AWS backend is connected.`;

  supportResponse.scrollIntoView({ behavior: "smooth", block: "center" });
});
