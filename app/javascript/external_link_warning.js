function externalLinkWarning() {
  const externalLinks = document.querySelectorAll('a[data-external-link="true"]');

  externalLinks.forEach(link => {
    link.addEventListener("click", function(event) {
      event.preventDefault();
      const proceed = confirm("このリンクは外部サイトに遷移します。続行しますか？");
      if (proceed) {
        window.open(link.href, "_blank");
      }
    });
  });
}

document.addEventListener("DOMContentLoaded", externalLinkWarning);