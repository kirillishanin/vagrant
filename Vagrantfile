# Указываем версию API конфигурации Vagrant
Vagrant.configure("2") do |config|

  # --- МАШИНА 1 (n8n) ---
  config.vm.define "n8n" do |n8n|
    # Образ ОС (Ubuntu 22.04)
    n8n.vm.box = "ubuntu/jammy64"
    # Имя внутри системы
    n8n.vm.hostname = "n8n"
    # Настройка сети: задаем IP и явно прописываем маску подсети (255.255.255.240)
    n8n.vm.network "private_network", ip: "10.77.133.2", netmask: "255.255.255.240"
	n8n.vm.network "public_network", bridge: "Intel(R) Dual Band Wireless-AC 3165"
    # Настройки для провайдера VirtualBox
    n8n.vm.provider "virtualbox" do |vb|
      # Имя виртуалки в интерфейсе VirtualBox
      vb.name = "n8n"
      # Память и ядра
      vb.memory = "1024"
      vb.cpus = 1
	end  
  end

  # --- МАШИНА 2 (ollama) ---
  config.vm.define "ollama" do |ollama|
    ollama.vm.box = "ubuntu/jammy64"
    ollama.vm.hostname = "ollama"
    # Указываем уникальный IP и ту же маску, чтобы они были в одной сети
    ollama.vm.network "private_network", ip: "10.77.133.3", netmask: "255.255.255.240"
	ollama.vm.network "public_network", bridge: "Intel(R) Dual Band Wireless-AC 3165"
    ollama.vm.provider "virualbox" do |vb|
      vb.name = "ollama"
      vb.memory = "4096"
      vb.cpus = 2
    end
  end

  # --- МАШИНА 3 (postgresql) ---
  config.vm.define "postgresql" do |posgtresql|
    posgtresql.vm.box = "ubuntu/jammy64"
    posgtresql.vm.hostname = "postgresql"
    # Указываем IP и маску
    posgtresql.vm.network "private_network", ip: "10.77.133.4", netmask: "255.255.255.240"
	posgtresql.vm.network "public_network", bridge: "Intel(R) Dual Band Wireless-AC 3165"
    posgtresql.vm.provider "virtualbox" do |vb|
      vb.name = "postgresql"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # --- МАШИНА 4 (wikijs) ---
  config.vm.define "wikijs" do |wikijs|
    wikijs.vm.box = "ubuntu/jammy64"
    wikijs.vm.hostname = "wikijs"
    # Указываем IP и маску
    wikijs.vm.network "private_network", ip: "10.77.133.5", netmask: "255.255.255.240"
	wikijs.vm.network "public_network", bridge: "Intel(R) Dual Band Wireless-AC 3165"
    wikijs.vm.provider "virtualbox" do |vb|
      vb.name = "wikijs"
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

end
