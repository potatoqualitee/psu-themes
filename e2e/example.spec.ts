import { test, expect } from '@playwright/test';

test('homepage has PowerShell in title and get started link linking to the intro page', async ({ page }) => {
  await page.goto('http://localhost:5000/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PowerShell Universal Dashboard/);

  await expect(page).toHaveURL('http://localhost:5000/');

  // Click div[role="button"]:has-text("Sidebar")
  await page.locator('div[role="button"]:has-text("Sidebar")').click();
  await expect(page).toHaveURL('http://localhost:5000/sidebar');
  
  // Uncheck #Home
  await page.locator('#Home').uncheck();
  await expect(page).toHaveURL('http://localhost:5000/sidebar');

});
