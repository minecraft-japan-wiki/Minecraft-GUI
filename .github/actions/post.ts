import fetch from "node-fetch"
import * as core from "@actions/core"
import * as github from "@actions/github"

const MW_API = process.env.MW_API;
const MW_CSRF_TOKEN = process.env.MW_CSRF_TOKEN;
const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
const MW_COOKIE = process.env.MW_COOKIE

/**
 * Get the source code from the repository.
 * @param {string} path file path
 * @returns {Promise<string>} source code
 */
async function getContentFromRepos(path: string) {
    if (!(GITHUB_TOKEN)) {
        throw new Error("no env values.")
    }

    const repo = github.context.repo
    const branch = github.context.ref
    const url = `https://api.github.com/repos/${repo.owner}/${repo.repo}/contents/${path}?ref=${branch}`;

    const res = await fetch(url, {
        headers: {
            'Authorization': `Bearer ${GITHUB_TOKEN}`,
            'Accept': 'application/vnd.github.v3.raw'
        }
    });

    if (!res.ok)
        throw new Error(`Failed to fetch file: ${res.statusText}`);

    return await res.text();
}

/**
 * Edit a wiki page.
 * @param {string} page page title
 * @param {string} content content
 * @returns {Promise<any>} response
 */
async function editPage(page: string, content: string) {
    if (!(MW_API && MW_CSRF_TOKEN && MW_COOKIE)) {
        throw new Error("no env values.")
    }

    const res = await fetch(`${MW_API}?format=json`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            Cookie: MW_COOKIE
        },
        body: new URLSearchParams({
            action: 'edit',
            title: page,
            text: content,
            token: MW_CSRF_TOKEN,
            summary: 'Posted via GitHub Actions',
            bot: 'true'
        }),
    });
    const data = await res.json();
    console.log('Edit response:', JSON.stringify(data, null, 2));

    if (data.edit && data.edit.result === 'Success') {
        console.log('✅ Page edited successfully');
    } else {
        console.warn('❌ Failed to edit page');
        console.warn(data)
        throw Error(data.error.info)
    }
    return data
}

async function main() {
    const data = [
        // css
        { target: "src/css/MinecraftGUI.css", dist: "MediaWiki:Gadget-MinecraftGUI.css" },
        // js
        { target: "src/js/MinecraftGUI.js", dist: "MediaWiki:Gadget-MinecraftGUI.js" },
        // lua
        { target: "src/lua/Slot.lua", dist: "Module:Slot/utils" },
        { target: "src/lua/Gui.lua", dist: "Module:Gui" },
        // lua components
        { target: "src/lua/components/Gui_Botania.lua", dist: "Module:Gui/Botania" },
        { target: "src/lua/components/Gui_BuildCraft.lua", dist: "Module:Gui/BuildCraft" },
        { target: "src/lua/components/Gui_EnderIO.lua", dist: "Module:Gui/EnderIO" },
        { target: "src/lua/components/Gui_Industrial Revolution by Redstone.lua", dist: "Module:Gui/Industrial Revolution by Redstone" },
        { target: "src/lua/components/Gui_IndustrialCraft2.lua", dist: "Module:Gui/IndustrialCraft2" },
    ]

    for (let i = 0; i < data.length; i++) {
        try {
            if (!(data[i].target && data[i].dist)) {
                throw Error("no env values.")
            }
            const content = await getContentFromRepos(data[i].target)
            await editPage(data[i].dist, content)
        } catch (e) {
            console.warn(e)
        }
    }

}

main().catch((e) => {
    console.error(e);
    process.exit(1);
})
