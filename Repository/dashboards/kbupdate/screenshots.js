// sleep for 25 seconds
var { chromium } = require('playwright');

(async function () {
    var themeparam = process.argv[2];
    
    var path = require('path');
    var fs = require('fs');
    var directoryPath = path.join(__dirname, 'themes');
    var file = path.join(directoryPath, `${themeparam}.json`);
    console.log(file);
   
    fs.readdir(directoryPath, async function (err, files) {
        if (err) {
            return console.log('Unable to scan directory: ' + err);
        }
        [file].forEach(async function (themefile) {
            // launch chromium browser
            var browser = await chromium.launch({
                headless: false,
                viewport: {
                    width: 1280, // 1280 in commit 1ee6578
                    height: 1720, // 720 in commit 1ee6578
                }
            });
            // create viewport with dark mode enabled,
            var context = await browser.newContext({});
            // get basename of themefile
            var theme = path.basename(themefile, '.json');
            console.log(theme);
            // connect to webpage
            var page = await context.newPage();
            await page.goto('http://localhost:5000');
            // await scrollFullPage(page);
            // wait for the page to load
            await page.waitForSelector('text=Table with Paging');
            // take a screenshot
            var lightscreenshot = path.join(__dirname, 'themes', 'screenshots', `${theme}-light.png`);
            await page.screenshot({ path: lightscreenshot, fullPage: true });
            // click the dark mode toggle
            await page.locator('header button').click();
            // take a screenshot
            var darkscreenshot = path.join(__dirname, 'themes', 'screenshots', `${theme}-dark.png`);
            await page.screenshot({ path: darkscreenshot, fullPage: true });
           
            await context.close();
            await browser.close();
        });
    });
})();

async function scrollFullPage(page) {
    await page.evaluate(async () => {
        await new Promise(resolve => {
            let totalHeight = 0;
            const distance = 100;
            const timer = setInterval(() => {
                const scrollHeight = document.body.scrollHeight;
                window.scrollBy(0, distance);
                totalHeight += distance;

                if (totalHeight >= scrollHeight) {
                    clearInterval(timer);
                    resolve();
                }
            }, 100);
        });
    });
}