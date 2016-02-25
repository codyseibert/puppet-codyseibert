# crontab -e

0 2 * * * /home/setter/backup.sh
*/5 * * * * /home/rpms/createrepo.sh
* 0 * * * /home/deploy.sh
