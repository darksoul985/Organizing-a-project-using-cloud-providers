#cloud-config
users:
  - name: ${ssh_user}
    groups: sudo
    shel: /bin/sh
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - ${ssh_public_key}

packages:
  - nginx

package_update: true
package_upgrade: false

write_files:
  - path: /var/www/html/index.html
    owner: root:root
    permissions: '0644'
    content: |
      <!DOCTYPE html>
      <html lang="ru">
      <head>
          <meta charset="UTF-8">
          <title>Yandex Cloud VM</title>
          <style>
              body {
                  font-family: Arial, sans-serif;
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                  justify-content: center;
                  min-height: 100vh;
                  margin: 0;
                  background: #f4f6f8;
                  color: #333;
              }
              h1 { margin-bottom: 24px; }
              img {
                  max-width: 80vw;
                  max-height: 70vh;
                  border-radius: 12px;
                  box-shadow: 0 4px 16px rgba(0,0,0,0.15);
              }
              .source {
                  margin-top: 20px;
                  font-size: 14px;
                  color: #666;
              }
              .source a { color: #0069ff; text-decoration: none; }
          </style>
      </head>
      <body>
          <h1>Привет из Yandex Cloud! 🐱</h1>
          <img src="${image_url}" alt="Kitten from Object Storage">
          <p class="source">
              Источник: <a href="${image_url}" target="_blank">${image_url}</a>
          </p>
      </body>
      </html>

runcmd:
  - systemctl enable nginx
  - systemctl restart nginx
