sudo apt-get install mutt
sudo apt-get install ssmtp
sudo service cron start

mkdir ~/.mutt

cat > ~/.mutt/muttrc <<EOF
set ssl_starttls=yes
set ssl_force_tls=yes

set imap_user = "change_this_user_name@gmail.com"
set imap_pass = "PASSWORD"

set from="change_this_user_name@gmail.com"
set realname="Your Name"

set folder = "imaps://imap.gmail.com/"
set spoolfile = "imaps://imap.gmail.com/INBOX"
set postponed="imaps://imap.gmail.com/[Gmail]/Drafts"

set header_cache = "~/.mutt/cache/headers"
set message_cachedir = "~/.mutt/cache/bodies"
set certificate_file = "~/.mutt/certificates"

set smtp_url = "smtps://change_this_user_name@gmail.com:PASSWORD@smtp.gmail.com:465/"

set move = no
set imap_keepalive = 900
EOF

