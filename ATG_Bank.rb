
# HESAP Bilgileri
User_Name = "Ahmet Tahsin"
$Password = "824746Tahsin"
#==========================
$Cash_in_Bank_TRY = 0.00
$Cash_in_Bank_USD = 0.00
$Cash_in_Bank_EUR = 0.00
$Cash_in_Bank_GOLD = 0.00

# Sabit Kurlar
#===========================
# 1 TRY ≈ 1/40.92 USD  (⇒ 1 USD ≈ 40.92 TRY)
TRY_TO_USD  = 1.0 / 40.92    # ≈ 0.0244

# 1 TRY ≈ 1/47.21 EUR (⇒ 1 EUR ≈ 47.21 TRY)
TRY_TO_EUR  = 1.0 / 47.21    # ≈ 0.0212

# 1 gr Altın ≈ 4370 TRY  ⇒ 1 TRY ≈ 1/4370 gr
TRY_TO_GOLD = 1.0 / 4370.0   # ≈ 0.000229
#===========================


# --- 1) Giriş mesajı ---
def login_account
  attempts = 3
  while attempts > 0
    print "Please enter the user name : "
    user_name = gets.chomp
    print "Please enter the password: "
    password = gets.chomp

    if user_name == User_Name && password == $Password
      puts "✅ Login successful!"
      return true
    else
      attempts -= 1
      puts "❌ Login failed! Please try again. Remaining attempts: #{attempts}"
    end
  end

  puts "You have exceeded the maximum number of attempts. Exiting the program."
  exit
end



# --- 2) Banka Menusu (Asıl Loop) ---

def bank_menu
loop do
puts "Welcome to the ATG Bank; Dear, #{User_Name}."
puts "=============================================="
puts "Please select an option, which action would you like to perform?"
puts "1. Deposit Money in your TRY account"
puts "2. Withdraw Money in your TRY account"
puts "3. Check Your Account Total Balance"
puts "4. Foreign Currency - Gold Transactions"
puts "5. Changing Password"
puts "6. Exit"
print "Please select an option: "
customer_choice = gets.chomp.to_i

case customer_choice
when 1
deposit_money_try
when 2
withdraw_money_try
when 3
check_balance_total
when 4
foreign_currency_gold_transactions  
when 5
change_password
when 6
puts "Thank you for using our bank. We wait again, goodbye!"
exit
else
puts "Invalid option. Please try again."
end
end
end


# Para Yatırma

def deposit_money_try
print "Please enter the amount to deposit in TRY: "
amount_deposit = gets.chomp.to_f
if amount_deposit > 0
$Cash_in_Bank_TRY += amount_deposit
puts "✅ Successfully deposited #{amount_deposit} TRY."
puts "===================================================="
else
puts "❌ Invalid deposit amount. Please enter a positive number."
puts "============================================================"
end
end

# Para Çekme

def withdraw_money_try
  print "Please enter the amount to withdraw in TRY: "
  amount_withdraw = gets.chomp.to_f
  if amount_withdraw > 0 && amount_withdraw <= $Cash_in_Bank_TRY
    $Cash_in_Bank_TRY -= amount_withdraw
    puts "✅ Successfully withdrew #{amount_withdraw} TRY."
    puts "===================================================="
  else
    puts "❌ Invalid withdrawal amount. That amount does not exceed your balance."
    puts "============================================================"
  end
end

# Bakiyeyi Kontrol Et

def check_balance_total
  puts "Your current total balance is:"
  puts "============================================================"
  puts "TRY: #{format('%.2f', $Cash_in_Bank_TRY)}"
  puts "USD: #{format('%.2f', $Cash_in_Bank_USD)}"
  puts "EUR: #{format('%.2f', $Cash_in_Bank_EUR)}"
  puts "GOLD: #{format('%.2f', $Cash_in_Bank_GOLD)} grams"
  puts "============================================================"
end


#Doviz Islemleri Full

def foreign_currency_gold_transactions
  puts "Welcome to the Foreign Currency - Gold Transactions section."
  puts "=============================================================="
  puts "Please select an option:"
  puts "1. Deposit Gold"
  puts "2. Withdraw Gold"
  puts "3. Check Gold Balance"
  puts "4. Deposit USD"
  puts "5. Withdraw USD"
  puts "6. Check USD Balance"
  puts "7. Deposit EUR"
  puts "8. Withdraw EUR"
  puts "9. Check EUR Balance"
  puts "10. Back to Main Menu"
  print "Please select an option: "
  
  currency_choice = gets.chomp.to_i

  case currency_choice
  when 1
    deposit_gold
  when 2
    withdraw_gold
  when 3
    check_gold_balance
  when 4
    deposit_usd
  when 5
    withdraw_usd
  when 6
    check_usd_balance
  when 7
    deposit_eur
  when 8
    withdraw_eur
  when 9
    check_eur_balance
  when 10 then
    bank_menu
  else
    puts "Invalid option. Please try again."
    puts
  end
end


#Altin AL

def deposit_gold
  print "Please enter the amount of gold to buy (grams): "
  amount_gold_grams = gets.chomp.to_f

  if amount_gold_grams <= 0
    puts "Invalid deposit amount. Please enter a positive number."
    return
  end

  # 1 TRY → TRY_TO_GOLD gram  ⇒  TRY ihtiyacı = gram / TRY_TO_GOLD
  cost_in_try = amount_gold_grams / TRY_TO_GOLD

  if $Cash_in_Bank_TRY >= cost_in_try
    $Cash_in_Bank_TRY  -= cost_in_try
    $Cash_in_Bank_GOLD += amount_gold_grams   # GOLD bakiyesi gram olarak tutuluyor
    puts "✅ Successfully bought #{amount_gold_grams} grams of gold for #{format('%.2f', cost_in_try)} TRY."
    puts "  Your new TRY balance is: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "==========================================================================="
  else
    puts "❌ Transaction failed! Not enough TRY balance."
    puts "   Needed: #{format('%.2f', cost_in_try)} TRY | You have: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "==========================================================================="
  end
end


# Altin Satis

def withdraw_gold
  print "Please enter the amount of gold to sell (grams): "
  amount_gold_grams = gets.chomp.to_f

  if amount_gold_grams <= 0
    puts "Invalid withdrawal amount. Please enter a positive number."
    return
  end

  if $Cash_in_Bank_GOLD >= amount_gold_grams
    # 1 gram GOLD → TRY_TO_GOLD TRY
    revenue_in_try = amount_gold_grams / TRY_TO_GOLD
    $Cash_in_Bank_GOLD -= amount_gold_grams
    $Cash_in_Bank_TRY += revenue_in_try
    puts "✅ Successfully sold #{amount_gold_grams} grams of gold for #{format('%.2f', revenue_in_try)} TRY."
    puts "  Your new TRY balance is: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "==========================================================================="
  else
    puts "❌ Transaction failed! Not enough GOLD balance."
    puts "   Needed: #{format('%.2f', amount_gold_grams)} grams | You have: #{format('%.2f', $Cash_in_Bank_GOLD)} grams."
    puts "==========================================================================="
  end
end


# Altin Bakiyesi Kontrol

def check_gold_balance
  puts "Your current gold balance is: #{format('%.2f', $Cash_in_Bank_GOLD)} grams."
  puts "==========================================================================="
end


# USD Deposito

def deposit_usd
  print "Please enter the amount of USD to deposit: "
  amount_usd = gets.chomp.to_f

  if amount_usd <= 0
    puts "Invalid deposit amount. Please enter a positive number."
    return
  end

  cost_in_try = amount_usd / TRY_TO_USD

  if $Cash_in_Bank_TRY >= cost_in_try
    $Cash_in_Bank_TRY -= cost_in_try
    $Cash_in_Bank_USD += amount_usd
    puts "✅ Successfully deposited #{amount_usd} USD for #{format('%.2f', cost_in_try)} TRY."
    puts "  Your new TRY balance is: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "====================================================================================================="
  else
    puts "❌ Transaction failed! Not enough TRY balance."
    puts "   Needed: #{format('%.2f', cost_in_try)} TRY | You have: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "====================================================================================================="
  end
end


# USD Çekme

def withdraw_usd
  print "Please enter the amount of USD to withdraw: "
  amount_usd = gets.chomp.to_f

  if amount_usd <= 0
    puts "Invalid withdrawal amount. Please enter a positive number."
    return
  end

  cost_in_try = amount_usd / TRY_TO_USD

  if $Cash_in_Bank_USD >= amount_usd
    $Cash_in_Bank_USD -= amount_usd
    $Cash_in_Bank_TRY += cost_in_try
    puts "✅ Successfully withdrew #{amount_usd} USD for #{format('%.2f', cost_in_try)} TRY."
    puts "  Your new TRY balance is: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "====================================================================================================="
  else
    puts "❌ Transaction failed! Not enough USD balance."
    puts "   Needed: #{format('%.2f', amount_usd)} USD | You have: #{format('%.2f', $Cash_in_Bank_USD)} USD."
    puts "====================================================================================================="
  end
end


# USD Bakiyesi Kontrol

def check_usd_balance
  puts "Your current USD balance is: #{format('%.2f', $Cash_in_Bank_USD)} USD."
  puts "========================================================================"
end


# EUR Deposito

def deposit_eur
  print "Please enter the amount of EUR to deposit: "
  amount_eur = gets.chomp.to_f

  if amount_eur <= 0
    puts "❌ Invalid deposit amount. Please enter a positive number."
    return
  end

  cost_in_try = amount_eur / TRY_TO_EUR

  if $Cash_in_Bank_TRY >= cost_in_try
    $Cash_in_Bank_TRY -= cost_in_try
    $Cash_in_Bank_EUR += amount_eur
    puts "✅ Successfully deposited #{amount_eur} EUR for #{format('%.2f', cost_in_try)} TRY."
    puts "  Your new TRY balance is: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "==========================================================================="
  else
    puts "❌ Transaction failed! Not enough TRY balance."
    puts "   Needed: #{format('%.2f', cost_in_try)} TRY | You have: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "==========================================================================="
  end
end


# EUR Çekme

def withdraw_eur
  print "Please enter the amount of EUR to withdraw: "
  amount_eur = gets.chomp.to_f

  if amount_eur <= 0
    puts "Invalid withdrawal amount. Please enter a positive number."
    return
  end

  cost_in_try = amount_eur / TRY_TO_EUR

  if $Cash_in_Bank_EUR >= amount_eur
    $Cash_in_Bank_EUR -= amount_eur
    $Cash_in_Bank_TRY += cost_in_try
    puts "✅ Successfully withdrew #{amount_eur} EUR for #{format('%.2f', cost_in_try)} TRY."
    puts "  Your new TRY balance is: #{format('%.2f', $Cash_in_Bank_TRY)} TRY."
    puts "====================================================================================================="
  else
    puts "❌ Transaction failed! Not enough EUR balance."
    puts "   Needed: #{format('%.2f', amount_eur)} EUR | You have: #{format('%.2f', $Cash_in_Bank_EUR)} EUR."
    puts "====================================================================================================="
  end
end


# EUR Bakiyesi Kontrol

def check_eur_balance
  puts "Your current EUR balance is: #{format('%.2f', $Cash_in_Bank_EUR)} EUR."
  puts "==========================================================================="
end


#Sifre Degistirme

def change_password
  print "Enter OLD password: "
  old = gets.chomp
  if old != $Password
    puts "❌ Wrong current password."
    return
  end

  print "Enter NEW password: "
  new_password = gets.chomp
  if new_password.strip.empty?
    puts "❌ Password cannot be empty."
    return
  end

  print "Type YES to confirm: "
  conf = gets.chomp
  if conf != "YES"
    puts "❌ Not confirmed."
    return
  end

  # Password sabitini güncelle
  Object.send(:remove_const, :Password) if Object.const_defined?(:Password)
  $Password = new_password
  puts "✅ Password changed successfully!"
end



# --- Programın Ana Akışı ---

login_account
bank_menu 

# --- Program Sonu ---
