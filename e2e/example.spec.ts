import { test, expect } from '@playwright/test';

test('homepage has PowerShell in title and get started link linking to the intro page', async ({ page }) => {
  await page.goto('http://localhost:5000/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/PowerShell Universal Dashboard/);

  // Expect a title "to contain" a substring.
  //await expect(page).toContainText('Newsletter Signup');
  await expect(page).toMatchText('Newsletter Signup');
});
