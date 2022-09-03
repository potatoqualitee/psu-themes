import { test, expect } from '@playwright/test';

test('homepage has PowerShell in title and get started link linking to the intro page', async ({ page }) => {

  await page.goto('http://localhost:5000/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PowerShell Universal Dashboard/);

  // create a locator
  const supportedIcons = page.locator('text=Supported Icons');

  // Expect an attribute "to be strictly equal" to the value.
  await expect(supportedIcons).toHaveAttribute('href', '/icons');

  // Click the get started link.
  await supportedIcons.click();

  // Expects the URL to contain intro.
  await expect(page).toHaveURL(/.*icons/);
  
  // Click div[role="button"]:has-text("Elements")
  // page.locator('div[role="button"]:has-text("Elements")').click();
  // await expect(page).toHaveURL('http://localhost:5000/elements');

  // Click div[role="button"]:has-text("Select Theme")
  // page.locator('div[role="button"]:has-text("Select Theme")').click();
  // await expect(page).toHaveURL('http://localhost:5000/theme');

});
