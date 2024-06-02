import { test, expect } from '@playwright/test';

const versions = [
  "5.0.17",
  "6.0.31",
  "7.0.20",
  "8.0.6"
];

test.use({ javaScriptEnabled: false });

for (const sut of versions) {
  const major_minor = `${sut.split('.').slice(0, 2).join('.')}`

  test.describe(`DOTNET version page ${major_minor}`, () => {
    test.describe.configure({
      retries: 4,
      timeout: 60 * 1000
    });

    const url = `https://dotnet.microsoft.com/en-us/download/dotnet/${major_minor}`;

    test.beforeEach(async ({ page }) => {
      await page.goto(`${url}`);
    })

    test('URL is valid', async ({ page }) => {
      await expect(page).toHaveURL(`${url}`);
    });
    test(`Check latest version v${sut}`, async ({ page }) => {
      await expect(page.locator('button[aria-controls="version_0"]')).toHaveText(sut)
    });

  });
}
