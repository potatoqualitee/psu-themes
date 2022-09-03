const playwright = require('playwright');
const { test } = require('@playwright/test');
import { expect } from '@playwright/test';

test('Simulations page', async ({ page }) => {
    for (const browserType of ['chromium', 'firefox', 'webkit']) {
        const browser = await playwright[browserType].launch();
        try {
            await page.goto('http://localhost:5000/');
            page.waitForSelector('text=Table with Paging');

            // Click div[role="button"]:has-text("Elements")
            page.locator('div[role="button"]:has-text("Elements")').click();
            await expect(page).toHaveURL('http://localhost:5000/elements');

            // Click div[role="button"]:has-text("Select Theme")
            page.locator('div[role="button"]:has-text("Select Theme")').click();
            await expect(page).toHaveURL('http://localhost:5000/theme');
        } catch (ex) {
            var png = "/tmp/screenshots/" + browserType + ".png";
            await page.screenshot({ path: png });
            throw ex
        } finally {
            await browser.close();
        }
    }
})();