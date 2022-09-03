import it, { expect } from '@playwright/test';

it('is a basic test with the page', async ({ page }) => {
    await page.goto('https://playwright.dev/');
    const name = await page.innerText('.home-navigation');
    expect(name).toBe('🎭 Playwright');
});