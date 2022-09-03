const playwright = require('playwright');
import { expect } from '@playwright/test';

(async () => {
    for (const browserType of ['chromium', 'firefox', 'webkit']) {
        const browser = await playwright[browserType].launch();
        try {
            const context = await browser.newContext();
            const page = await context.newPage();

            await page.goto('http://localhost:5000/');
            page.waitForSelector('text=Table with Paging');

            // Click div[role="button"]:has-text("Elements")
            page.locator('div[role="button"]:has-text("Elements")').click();
            await expect(page).toHaveURL('http://localhost:5000/elements');

            // Click div[role="button"]:has-text("Select Theme")
            page.locator('div[role="button"]:has-text("Select Theme")').click();
            await expect(page).toHaveURL('http://localhost:5000/theme');
        } catch (error) {
            console.error(`Trying to run test on ${browserType}: ${error}`);
        } finally {
            await browser.close();
        }
    }
})();