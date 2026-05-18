# 1. Force kill any running logstash process
pkill -9 -f logstash
sleep 3

# 2. Verify nothing is running
ps aux | grep logstash | grep -v grep

# 3. Clean the pipeline cache/data
rm -rf /usr/share/logstash/data/queue/*
rm -rf /usr/share/logstash/data/dead_letter_queue/*

# 4. Fix permissions again after root cleanup
chown -R logstash:logstash /usr/share/logstash/data

# 5. Confirm only ONE config file exists
ls -la /etc/logstash/conf.d/

# 6. Start fresh
systemctl start logstash
journalctl -u logstash -f