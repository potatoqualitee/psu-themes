const { test } = require('@playwright/test');

test.describe('Output Edit', () => {
  test('Simulations page', function ({ page }) {
          page.goto('http://localhost:5000/');
          page.waitForSelector('text=Table with Paging');

          // Click div[role="button"]:has-text("Elements")
          page.locator('div[role="button"]:has-text("Elements")').click();
          expect(page).toHaveURL('http://localhost:5000/elements');

          // Click div[role="button"]:has-text("Select Theme")
          page.locator('div[role="button"]:has-text("Select Theme")').click();
          expect(page).toHaveURL('http://localhost:5000/theme');
      });
})