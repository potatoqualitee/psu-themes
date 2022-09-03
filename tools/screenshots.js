var { chromium } = require('playwright');

(async function () {
    var themeparam = process.argv[2];

    var path = require('path');
    var fs = require('fs');
    var directoryPath = path.join(__dirname, 'themes');
    var file = path.join(directoryPath, `${themeparam}.json`);
    console.log("processing " + file);

    fs.readdir(directoryPath, async function (err) {
        if (err) {
            return console.log('Unable to scan directory: ' + err);
        }
        [file].forEach(async function (themefile) {
            // launch chromium browser
            var browser = await chromium.launch({
                headless: true
            });
            // creating viewport with dark mode enabled doesn't work on this site
            // just create an empty context
            //var context = await browser.newContext({});
            // create new context with 1920×1080
            var context = await browser.newContext({
                viewport: {
                    width: 1520,
                    height: 790,
                }
            });

            // get basename of themefile
            var theme = path.basename(themefile, '.json');
            // connect to webpage
            var page = await context.newPage();
            await page.goto('http://localhost:5000');
            // wait for the page to load
            await page.waitForSelector('text=Table with Paging');
            await page.waitForSelector('text=Table with Paging');
            // take a screenshot
            var lightscreenshot = path.join(__dirname, 'assets', 'screenshots', `${theme}-light.png`);
            await page.screenshot({ path: lightscreenshot });
            // click the dark mode toggle
            await page.locator('header button').click();
            // wait for the page to load
            await page.waitForSelector('text=Table with Paging');
            await page.waitForSelector('text=Table with Paging');
            // take a screenshot
            var darkscreenshot = path.join(__dirname, 'assets', 'screenshots', `${theme}-dark.png`);
            await page.screenshot({ path: darkscreenshot });

            await context.close();
            await browser.close();
        });
    });
})();