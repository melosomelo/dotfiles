// Script to open selected config files for nvim
const { spawn } = require("child_process");
const fs = require("fs");
const { exit } = require("process");
const NVIM_CONFIG_DIRECTORY = "/Users/mateusnascimento/.config/nvim";

function question(str) {
  return new Promise((res, rej) => {
    require("readline")
      .createInterface({ input: process.stdin, output: process.stdout })
      .question(str, (response) => {
        return res(response);
      });
  });
}

function getPossibleConfigFiles() {
  const luaUserFolder = fs
    .readdirSync(`${NVIM_CONFIG_DIRECTORY}/lua/user`)
    .filter((filename) => filename.match(/.lua$/))
    .map((filename) => filename.replace(/.lua$/, ""));
  return ["init", ...luaUserFolder];
}

async function main() {
  const [, , ...args] = process.argv;
  const possibleValues = getPossibleConfigFiles();
  let chosenFiles = [];
  let validArgs;
  if (args.length === 0) {
    const response = await question(
      "> No files for editing were specified. Which files do you want to edit?\n"
    );
    chosenFiles = response.split(" ");
  } else {
    chosenFiles = args;
  }
  validArgs = chosenFiles.every((filename) =>
    possibleValues.includes(filename)
  );
  if (!validArgs) {
    return console.log(
      `> Invalid filenames were provided. Possible values are:\n${possibleValues
        .map((filename) => `  -${filename}`)
        .join("\n")}`
    );
  }
  const nvim = spawn(
    "nvim",
    [
      "-p",
      ...chosenFiles.map((filename) => {
        // mapping to the correct filenames
        if (filename === "init") {
          return `/Users/mateusnascimento/.config/nvim/init.lua`;
        }
        return `/Users/mateusnascimento/.config/nvim/lua/user/${filename}.lua`;
      }),
    ],
    { stdio: "inherit" }
  );
  nvim.on("exit", (e) => {
    if (e) {
      return console.log("> Something went wrong.\n");
    }
    console.log("> Edited successfully!");
    exit(0);
  });
}

(async () => {
  await main();
})();
