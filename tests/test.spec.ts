import type { Page } from '@playwright/test';
import { test, expect } from './baseFixtures';

test.describe('Example Repo', () => {
    test.beforeEach(async ({ page }) => {
        await page.goto('http://localhost:5000/');
    });

    test('Should generate correct aria attributes', async ({ page }) => {
        await page.waitForSelector('text=Table with Paging');
        await expect(page).toHaveURL('http://localhost:5000/elements');
    });

    test('Should navigate on keyboard arrow left and arrow right when focused', async ({ page }) => {
        await page.locator('div[role="button"]:has-text("Select Theme")').click();
        await expect(page).toHaveURL('http://localhost:5000/theme');
    });
});