const { test } = require('@playwright/test');

test.describe('Output Edit', () => {
  test('Simulations page', async ({ page }) => {
      await page.goto('http://localhost:5000/');

      // Click div[role="button"]:has-text("Elements")
      await page.locator('div[role="button"]:has-text("Elements")').click();
      await expect(page).toHaveURL('http://localhost:5000/elements');

      // Click div[role="button"]:has-text("Select Theme")
      await page.locator('div[role="button"]:has-text("Select Theme")').click();
      await expect(page).toHaveURL('http://localhost:5000/theme');
  });
})