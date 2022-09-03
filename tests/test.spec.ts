import { test, expect } from '@playwright/test';

test('homepage has PowerShell in title and get started link linking to the intro page', async ({ page }) => {
  await page.goto('http://localhost:5000/');

  // this is a minimal test -- i gotta figure out how to do more later
  await expect(page).toHaveTitle(/PowerShell Universal Dashboard/);
  await expect(page).toHaveURL('http://localhost:5000/');
});
