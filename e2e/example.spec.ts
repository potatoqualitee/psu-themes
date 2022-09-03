import { test, expect } from '@playwright/test';

test('homepage has PowerShell in title and get started link linking to the intro page', async ({ page }) => {
  await page.goto('http://localhost:5000/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PowerShell Universal Dashboard/);

  // Click div[role="button"]:has-text("Select Theme")
  page.locator('div[role="button"]:has-text("Select Theme")').click();
  await expect(page).toHaveURL('http://localhost:5000/theme');
});
