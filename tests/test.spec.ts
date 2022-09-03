const playwright = require('playwright');

(async () => {
    for (const browserType of ['chromium', 'firefox', 'webkit']) {
        const browser = await playwright[browserType].launch();
        try {
            const context = await browser.newContext();
            const page = await context.newPage();
            await page.goto('https://google.com');
            await page.fill('input[name=q]', 'cheese');
            await page.press('input[name=q]', 'Enter');
            await page.waitForNavigation();

            // page.waitForSelector('div#rso h3').then(firstResult => console.log(`${browserType}: ${firstResult.textContent()}`)).catch(error => console.error(`Waiting for result: ${error}`));

            await page.waitForSelector('div#rso h3');
            const firstResult = await page.$eval('div#rso h3', firstRes => firstRes.textContent);
            console.log(`${browserType}: ${firstResult}`)
        } catch (error) {
            console.error(`Trying to run test on ${browserType}: ${error}`);
        } finally {
            await browser.close();
        }
    }
})();