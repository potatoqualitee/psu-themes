const { test } = require('@playwright/test');
import { expect } from '@playwright/test';

test.describe('Output Edit', () => {
  test('Simulations page', async ({ page }) => {
      await page.goto('http://localhost:5000/');
      await page.waitForSelector('text=Table with Paging');

      // Click div[role="button"]:has-text("Elements")
      page.locator('div[role="button"]:has-text("Elements")').click();
      await expect(page).toHaveURL('http://localhost:5000/elements');

      // Click div[role="button"]:has-text("Select Theme")
      page.locator('div[role="button"]:has-text("Select Theme")').click();
      await expect(page).toHaveURL('http://localhost:5000/theme');
  });
})