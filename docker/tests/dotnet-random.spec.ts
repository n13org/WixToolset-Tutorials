import { test, expect } from '@playwright/test';
import fs from 'fs'
import path from 'path'

test.use({ javaScriptEnabled: false });

const options: any = JSON.parse(fs.readFileSync(path.join(__dirname, `../data/data/dotnet-all.json`), 'utf-8'));
const loop_step = Math.floor(options.length / 5); // Use a constant step, random indexes do not work -> because the test title would change

test("Options are loaded", () => {
  expect(options).not.toBeNull();
});

test("Loop step >= 0 and <= length", () => {
  expect(loop_step).toBeGreaterThanOrEqual(0);
  expect(loop_step).toBeLessThanOrEqual(options.length);
});

for (let index = 0; index < options.length; index += loop_step) {
  const sut = options[index];

  test.describe(`[${index}] ${sut.runtime} DOTNET v${sut.version} ${sut.os} ${sut.platform}`, () => {
    test.describe.configure({
      retries: 6,
      timeout: 3 * 60 * 1000
    });

    const url = `https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/${sut.runtime}-${sut.version}-${sut.os}-${sut.platform}-installer`;

    test.beforeEach(async ({ page }) => {
      await page.goto(`${url}`);
    })

    test('Has title', async ({ page }) => {
      await expect(page, "version check").toHaveTitle(new RegExp('(v' + sut.version + ')'));
      await expect(page, "platform check").toHaveTitle(new RegExp(sut.platform, 'i'));
    });
    test('URL is valid', async ({ page }) => {
      await expect(page).toHaveURL(`${url}`);
    });
    test("Check direct link", async ({ page }) => {
      await expect(page.locator("#directLink")).toHaveAttribute("href", sut.link)
    });
    test("Check hash", async ({ page }) => {
      await expect(page.locator("#checksum")).toHaveValue(sut.hash)
    });

  });
}
