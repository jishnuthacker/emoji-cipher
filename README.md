# 🔐 Emoji Cipher

**Send secret messages that look like random emojis.** Your friends won't know what hit them and neither will anyone snooping. 😏

[![Live Demo](https://img.shields.io/badge/Live_Demo-7c3aed?style=for-the-badge&logo=googlechrome&logoColor=white)](https://jishnuthacker.github.io/emoji-cipher/)
[![Made with JS](https://img.shields.io/badge/Pure_JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](#)
---

## 💡 What is this?

Ever wanted to text your friend something like:

> 🤨 😋 😘 😋 🎅 😆 😤 🤎 👾 😢 🤍 🙂 🤔 🤥 😬 🥴 😟 🎁

…and have them **actually decode it** back to your original message? That's literally what this does.

Emoji Cipher takes your text, runs it through **two layers of classical encryption** (Vigenère + Playfair), and spits out a string of emojis. Only someone with the **same secret key** can decrypt it back. Wrong key? They get nothing. 🤷

---

## ⚡ Quick Start

1. **Clone it** (or just download the HTML file)
   ```bash
   git clone https://github.com/jishnuthacker/emoji-cipher.git
   ```

2. **Open `index.html`** in any browser. That's it. No server, no npm, no build step.

3. **Encrypt:** Type your message → enter a secret key → hit Execute → copy the emojis.

4. **Decrypt:** Switch to Decrypt → paste the emojis → enter the **same key** → hit Execute → read the original message.

> **Pro tip:** Share the key with your friends through a different channel (in person, a call, etc.) — never send the key along with the encrypted message. That defeats the purpose 😄

---

## 🔧 How It Works (The Nerdy Part)

```
YOUR TEXT
    │
    ▼
┌─────────────────┐
│  Magic Header   │  ← Hidden tag for key verification
│  prepended      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Vigenère Layer  │  ← Shifts each character using your key
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Playfair Layer  │  ← Swaps letter pairs using a 5×5 matrix
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Emoji Mapping   │  ← Each character → one of 95 emojis
└────────┬────────┘
         │
         ▼
   😀 😁 🤣 😃 ...
```

**Decryption** reverses the whole pipeline. The magic header is checked at the end if it doesn't match, you entered the wrong key. Simple.

---

## 🤔 Why Emojis?

- They look **completely harmless** in a chat
- Nobody suspects a wall of emojis is actually encrypted data
- It's **way more fun** than looking at `aG9sYSBib3Nz...`
- Perfect for sending inside jokes, surprise plans, or just messing around 🎉

---

## 📁 What's In The Repo

```
📦 emoji-cipher
├── 🌐 index.html          ← The entire app (open this)
├── 🧮 emoji_cipher.m      ← MATLAB reference implementation
└── 📖 README.md           ← You're reading it
```

---

## 🛡️ Is It Actually Secure?

Let's be real — this uses **classical ciphers**, not military-grade AES-256. It's strong enough to:

- ✅ Stop anyone casually reading your messages
- ✅ Prevent copy-paste reverse engineering (key required)
- ✅ Detect wrong keys automatically

But it won't protect you from the NSA. For that, use Signal. 😂

---

## 🚀 Tech

- **Zero dependencies** -pure HTML, CSS, JavaScript
- **No backend** - everything runs in your browser
- **No data leaves your device** - literally nothing is sent anywhere
- Works offline once the fonts load

---

## 📄 License

MIT - do whatever you want with it.

---

<p align="center">
  <strong>🔐 Encrypt. 😀 Send. 🔓 Decode.</strong><br>
  <em>Because plain text is boring.</em>
</p>
