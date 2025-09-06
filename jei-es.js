const quotesWork = [
	"And that there is not for man except that (good) for which he strives— Surah Al-Najm:39",
	"I'm a great believer in luck, and I find the harder I work, the more I have of it — Thomas Jefferson ",
	"Success is not final; failure is not fatal: It is the courage to continue that counts — Winston Churchill",
	"The reward of a thing well done is to have done it — Ralph Waldo Emerson",
	"Quality means doing it right when no one is looking — Mark Twain",
	"If you get tired, learn to rest, not to quit — Banksy",
	"In the name of God, stop a moment, cease your work, look around you ― Leo Tolstoy",
	"Action may not always bring happiness, but there is no happiness without action ― William James",
	"When he worked, he really worked. But when he played, he really PLAYED ― Dr. Seuss",
	"Work without love is slavery ― Mother Teresa"
]

const quotesLife =[
	"And whether ye hide your word or publish it, He certainly has (full) knowledge, of the secrets of (all) hearts — Surah Al-Mulk:13",
	"Life is what happens to us while we are making other plans — John Lennon"
]

const quotesBalance =[
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
]


let quoteWorkCard = document.getElementById("quote-work")
quoteWorkCard.innerText = quotesWork[Math.floor(Math.random() * quotesWork.length)]
setInterval(() => {
  quoteWorkCard.innerText = quotesWork[Math.floor(Math.random() * quotesWork.length)]
}, Math.floor(Math.random() * (9876 - 4567 + 1)) + 4567)

let quoteLifeCard = document.getElementById("quote-life")
quoteLifeCard.innerText = quotesLife[Math.floor(Math.random() * quotesLife.length)]
setInterval(() => {
  quoteLifeCard.innerText = quotesLife[Math.floor(Math.random() * quotesLife.length)]
}, Math.floor(Math.random() * (9876 - 4567 + 1)) + 4567)

let quoteBalanceCard = document.getElementById("quote-balance")
quoteBalanceCard.innerText = quotesWork[Math.floor(Math.random() * quotesWork.length)]
setInterval(() => {
  quoteBalanceCard.innerText = quotesWork[Math.floor(Math.random() * quotesWork.length)]
}, Math.floor(Math.random() * (9876 - 4567 + 1)) + 4567)

// Auto Scroll 'card-body'
document.addEventListener("DOMContentLoaded", () => {
  const cardBodies = document.querySelectorAll(".card-body");

  // Utility: random delay between 3–7s
  function randomDelay() {
    return (Math.floor(Math.random() * 5) + 3) * 1000; // ms
  }

  // Smooth scroll to target position
  function smoothScroll(element, target, duration = 1000) {
    return new Promise(resolve => {
      const start = element.scrollTop;
      const distance = target - start;
      let startTime = null;

      function step(timestamp) {
        if (!startTime) startTime = timestamp;
        const progress = Math.min((timestamp - startTime) / duration, 1);
        element.scrollTop = start + distance * progress;

        if (progress < 1) {
          requestAnimationFrame(step);
        } else {
          resolve();
        }
      }

      requestAnimationFrame(step);
    });
  }

  // Loop behaviour for one element
  async function autoScroll(element) {
    while (true) {
      await new Promise(r => setTimeout(r, randomDelay()));
      await smoothScroll(element, element.scrollHeight - element.clientHeight);
      
      await new Promise(r => setTimeout(r, randomDelay()));
      await smoothScroll(element, 0);
    }
  }

  // Apply to all .card-body elements
  cardBodies.forEach(el => {
    if (el.scrollHeight > el.clientHeight) {
      autoScroll(el);
    }
  });
});
