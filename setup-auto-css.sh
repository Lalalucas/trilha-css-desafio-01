#!/usr/bin/env bash
set -e

echo "🔐 Verificando se chave SSH existe..."
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "🗝️ Gerando nova chave SSH..."
    ssh-keygen -t rsa -b 4096 -C "lucasescobarmorais@gmail.com" -f ~/.ssh/id_rsa -N ""
    echo "✅ Chave pública gerada:"
    cat ~/.ssh/id_rsa.pub
    echo "⚠️ Copie a chave acima e adicione no GitHub: https://github.com/settings/keys"
    exit 1
fi

echo "📁 Limpando repositório antigo (se existir)..."
rm -rf trilha-css-desafio-01

echo "📥 Clonando repositório oficial..."
git clone https://github.com/digitalinnovationone/trilha-css-desafio-01.git
cd trilha-css-desafio-01

echo "🔧 Configurando remotos..."
git remote rename origin upstream

# === CRIAÇÃO DO REPO VIA API ===
echo "🌐 Criando repositório pessoal no GitHub (se necessário)..."

read -p "📌 Digite seu GitHub Token: " GITHUB_TOKEN

curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user/repos -d '{"name":"trilha-css-desafio-01", "private":false}' | grep -q 'full_name' && echo "✅ Repositório criado com sucesso (ou já existia)."

git remote add origin git@github.com:Lalalucas/trilha-css-desafio-01.git

echo "🌿 Criando nova branch: lucas-open-source-css"
git checkout -b lucas-open-source-css

echo "📝 Substituindo README.md personalizado..."
cat > README.md << 'EOT'
<h1 align="center">🚀 Minha Jornada com Open Source & Desenvolvimento Seguro</h1>

<p align="center">
  <strong>Desenvolvedor | Especialista em Segurança da Informação | Contribuidor Open Source</strong><br>
  <a href="mailto:lucasescobarmorais@gmail.com">lucasescobarmorais@gmail.com</a> • 
  <a href="https://github.com/Lalalucas">GitHub</a> • 
  <a href="https://linkedin.com/in/lucasgdm">LinkedIn</a> • 
  <a href="https://signal.me/#eu/Cw8TsrwvMGUxNxVIVcel3uA4uI0s8xr5rRz6Zi7YsrHuLOqO1Q9G-IZ2z4bxm3lF">Signal: MoraisLGM</a>
</p>

## 🏆 Conquista no Desafio DIO: "Me Criando"
Participei e concluí com sucesso o desafio **"Me Criando"** da plataforma [DIO.me](https://dio.me)...

📄 [Visualizar meu certificado aqui](https://www.dio.me/certificate/3HCRYICV/share)

<p align="center"><sub>Desenvolvido por Lucas Gabriel de Morais © 2025</sub></p>
EOT

echo "📦 Commitando alterações..."
git add README.md
git commit -m "🚀 Personalização com minha jornada open source e segurança"

echo "📤 Enviando para repositório pessoal..."
git push -u origin lucas-open-source-css

echo "✅ Tudo pronto! Acesse o Pull Request:"
echo "🔗 https://github.com/Lalalucas/trilha-css-desafio-01/compare/main...lucas-open-source-css?expand=1"
