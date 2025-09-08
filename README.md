# 🏦 Ruby Application Trials – **The ATG Bank**

**ATG Bank** is a small, basic, educational Ruby project built to practice basic syntax and CLI (command-line interface) interactions.  
The application simulates a simple banking system, managing balances in **TRY / USD / EUR / GOLD**, supporting deposits, withdrawals, currency exchange, and password management.

---

## ✨ Features

- 🔐 **Login with Limited Attempts** – Username/password check with 3 tries before exit  
- 💼 **TRY Account** – Deposit and withdraw local currency  
- 💱 **Foreign Currency & Gold Transactions**
  - USD / EUR **deposit, withdraw, balance check**
  - GOLD (grams) **buy, sell, balance check**
- 📊 **Total Balance Overview** – View balances in TRY, USD, EUR, and GOLD  
- 🔑 **Password Management** – Change password with old-password verification  
- 🧮 **Static Exchange Rates (demo only)**
  - `1 USD ≈ 40.92 TRY`  
  - `1 EUR ≈ 47.21 TRY`  
  - `1 gr GOLD ≈ 4370 TRY`

---

## 🚀 Installation & Run

```bash
# Clone the repository
git clone https://github.com/<username>/Ruby-Application-Trials---The_ATG_Bank.git
cd Ruby-Application-Trials---The_ATG_Bank

# Run with Ruby
ruby ATG_Bank.rb
