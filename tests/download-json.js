const { chromium } = require('playwright');

(async () => {
    const browser = await chromium.launch({ headless: true, downloadsPath: '' });
    const page = await browser.newPage({ acceptDownloads: true });

    await page.goto('https://windowsterminalthemes.dev/');

    const [download] = await Promise.all([
        page.waitForEvent('download'),
        page.locator('text=Download .json of themes').click()
    ]);
    await download.saveAs(download.suggestedFilename());

    await browser.close();
})();