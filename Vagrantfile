# Указываем версию API конфигурации Vagrant
Vagrant.configure("2") do |config|

  # --- МАШИНА 1 (n8n) ---
  config.vm.define "n8n" do |n8n|
    # Образ ОС (Ubuntu 22.04)
    web.vm.box = "ubuntu/jammy64"
    # Имя внутри системы
    web.vm.hostname = "n8n"
    # Настройка сети: задаем IP и явно прописываем маску подсети (255.255.255.240)
    web.vm.network "private_network", ip: "10.77.133.2", netmask: "255.255.255.240"
    # Настройки для провайдера VirtualBox
    web.vm.provider "virtualbox" do |vb|
      # Имя виртуалки в интерфейсе VirtualBox
      vb.name = "n8n"
      # Память и ядра
      vb.memory = "1024"
      vb.cpus = 1
	end  
  end

  # --- МАШИНА 2 (ollama) ---
  config.vm.define "ollama" do |ollama|
    db.vm.box = "ubuntu/jammy64"
    db.vm.hostname = "ollama"
    # Указываем уникальный IP и ту же маску, чтобы они были в одной сети
    db.vm.network "private_network", ip: "10.77.133.3", netmask: "255.255.255.240"
    db.vm.provider "ollama" do |vb|
      vb.name = "Project-DB"
      vb.memory = "2048"
      vb.cpus = 2
    end
  end

  # --- МАШИНА 3 (postgresql) ---
  config.vm.define "postgresql" do |posgtresql|
    app.vm.box = "ubuntu/jammy64"
    app.vm.hostname = "postgresql"
    # Указываем IP и маску
    app.vm.network "private_network", ip: "10.77.133.4", netmask: "255.255.255.240"
    app.vm.provider "virtualbox" do |vb|
      vb.name = "postgresql"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # --- МАШИНА 4 (wikijs) ---
  config.vm.define "wikijs" do |wikijs|
    storage.vm.box = "ubuntu/jammy64"
    storage.vm.hostname = "wikijs"
    # Указываем IP и маску
    storage.vm.network "private_network", ip: "10.77.133.4", netmask: "255.255.255.240"
    storage.vm.provider "virtualbox" do |vb|
      vb.name = "wikijs"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

end
