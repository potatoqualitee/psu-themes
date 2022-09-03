import { PlaywrightTestConfig, devices } from '@playwright/test';

const config: PlaywrightTestConfig = {
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  testDir: './tests',
  outputDir: './tests/results',
  reporter: 'list',
  webServer: {
    command: 'docker run --name powershelluniversal --rm -d  -p 5000:5000/tcp universal-persistent:latest',
    reuseExistingServer: !process.env.CI,
    url: 'http://localhost:5000',
    env: {
      NODE_ENV: 'test',
      USE_BABEL_PLUGIN_ISTANBUL: '1',
    },
  },
  use: {
    trace: 'on-first-retry',
  },
  expect: {
    toMatchSnapshot: { threshold: 0.1 },
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
};

export default config;
