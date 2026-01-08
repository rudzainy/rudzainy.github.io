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
	"Life is what happens to us while we are making other plans — John Lennon",
	"You may not control all the events that happen to you, but you can decide not to be reduced by them — Maya Angelou",
	"Life is very interesting … In the end, some of your greatest pains become your greatest strengths — Drew Barrymore",
	"The big secret in life is that there is no big secret. Whatever your goal, you can get there if you’re willing to work — Oprah Winfrey",
	"What we do for ourselves dies with us. What we do for others and the world remains and is immortal — Albert Pine",
	"It does not matter how long you are spending on the earth, how much money you have gathered, or how much attention you have received. It is the amount of positive vibration you have radiated in life that matters — Amit Ray",
	"When thinking about life, remember this: no amount of guilt can change the past and no amount of anxiety can change the future — Unknown",
	"The two most important days in your life are the day you’re born and the day you find out why — Mark Twain",
	"In any situation in life, you always have three choices: you can change it, you can accept it, or you can leave it — Naval Ravikant",
	"My life is my message – Mahatma Gandhi",
	"If you want to be happy, be — Leo Tolstoy",
	"Spread love everywhere you go — Mother Teresa",
	"Let love rule — Lenny Kravitz",
	"He who has a why to live can bear almost any how — Friedrich Nietzsche",
	"The best things in life aren’t things — Unknown",
	"Life is ten percent what happens to you and ninety percent how you respond to it — Lou Holtz",
	"In a gentle way, you can shake the world — Mahatma Gandhi",
]

const quotesBalance =[
	"Mathematics expresses values that reflect the cosmos, including orderliness, balance, harmony, logic, and abstract beauty ― Deepak Chopra",
	"You must let what happens happen. Everything must be equal in your eyes, good and evil, beautiful and ugly, foolish and wise ― Michael Ende",
	"Everything has boundaries. The same holds true with thought. You shouldn't fear boundaries, but you should not be afraid of destroying them. That's what is most important if you want to be free: respect for and exasperation with boundaries ― Haruki Murakami",
	"Life is like riding a bicycle. To keep your balance, you must keep moving ― Albert Einstein",
	"Balance is not something you find, it’s something you create — Jana Kingsford",
	"Be moderate in order to taste the joys of life in abundance — Epicurus",
	"You can't do a good job if your job is all you do — Katie Thurmes"
]


let quoteWorkCard = document.getElementById("quote-work")
if(quoteWorkCard != null) {
	quoteWorkCard.innerText = quotesWork[Math.floor(Math.random() * quotesWork.length)]
	setInterval(() => {
	  quoteWorkCard.innerText = quotesWork[Math.floor(Math.random() * quotesWork.length)]
	}, Math.floor(Math.random() * (9876 - 4567 + 1)) + 4567)
}


let quoteLifeCard = document.getElementById("quote-life")
if(quoteLifeCard != null) {
	quoteLifeCard.innerText = quotesLife[Math.floor(Math.random() * quotesLife.length)]
	setInterval(() => {
	  quoteLifeCard.innerText = quotesLife[Math.floor(Math.random() * quotesLife.length)]
	}, Math.floor(Math.random() * (9876 - 4567 + 1)) + 4567)
}

let quoteBalanceCard = document.getElementById("quote-balance")
if(quoteBalanceCard != null) {
	quoteBalanceCard.innerText = quotesBalance[Math.floor(Math.random() * quotesBalance.length)]
	setInterval(() => {
	  quoteBalanceCard.innerText = quotesBalance[Math.floor(Math.random() * quotesBalance.length)]
	}, Math.floor(Math.random() * (9876 - 4567 + 1)) + 4567)
}

// Auto Scroll 'card-body'
document.addEventListener("DOMContentLoaded", () => {
  const cardBodies = document.querySelectorAll(".card-body");

  // Utility: random delay between 3–7s
  function randomDelay() {
    return (Math.floor(Math.random() * 5) + 3) * 1000; // ms
  }
  // Utility: random scroll duration between 1–3s
  function randomDuration() {
    return (Math.floor(Math.random() * 3) + 1) * 1000; // ms
  }

  // Smooth scroll to target position
  function smoothScroll(element, target, duration = randomDuration()) {
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

// Scroll Affordance - Show fade indicators on horizontal scroll sections
document.addEventListener("DOMContentLoaded", () => {
  const scrollWrappers = document.querySelectorAll('.scroll-wrapper');

  scrollWrappers.forEach(wrapper => {
    const scrollArea = wrapper.querySelector('.overflow-x-scroll');
    if (!scrollArea) return;

    function updateFades() {
      const scrollLeft = scrollArea.scrollLeft;
      const scrollWidth = scrollArea.scrollWidth;
      const clientWidth = scrollArea.clientWidth;

      // Show left fade if scrolled right
      if (scrollLeft > 10) {
        wrapper.classList.add('show-left-fade');
      } else {
        wrapper.classList.remove('show-left-fade');
      }

      // Show right fade if more content to scroll
      if (scrollLeft < scrollWidth - clientWidth - 10) {
        wrapper.classList.add('show-right-fade');
      } else {
        wrapper.classList.remove('show-right-fade');
      }
    }

    // Initial check
    updateFades();

    // Update on scroll
    scrollArea.addEventListener('scroll', updateFades, { passive: true });

    // Update on resize
    window.addEventListener('resize', updateFades, { passive: true });
  });
});

const ansArray = [
	"true","correct","yes","right","accurate","valid",
	"betul","sungguh","ya","benar","tepat","haah","ha'ah",
	"yup","yups","y","t","1","em","yea",
	"hai",
	"ran'galhu","rangalhu","kanaaiy","munaasibu","aan","aan'","saḩḩa","sahha",
];

let hackering = () => {
  jawaban = document.getElementById("answer").value;
  console.log(jawaban);
  if(ansArray.includes(jawaban.toLowerCase())) {
    const title = "The Doorway <i>is Opened!</i>";
    let modalTitle = document.getElementById('takdeeModalLabel');
    modalTitle.innerHTML = title;
    let box = document.getElementById('box');
    box.innerHTML = "Congrtulations code breaker person! 👀<br />Here are some goodies for you:<br /><ol><li><a href='/docs/'>Some documents</a></li><li>...</li><li>Unlisted YouTube videos:<ul><li><a href='https://youtu.be/haeEC00aPTM'>Maya x Rudzainy Solemnization</a></li><li><a href='https://youtu.be/VVevtD-_F8Y'>Test link</a></li></ul></li><li><a href='https://rudzainy.blogspot.com/'>Old blog</a></li></ol><br /><h2>Thinking of a name for this section 🤔</h2><ul><li><a href='/components/index.html'>Components</a></li><li><a href='https://rudzainy.github.io'>rudzainy.github.io</a></li><li>3</li><li>4</li></ul>";
  };
};
