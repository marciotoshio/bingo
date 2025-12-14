require "aws-sdk-sts"
require "aws-sdk-polly"

# Step 4a: Connect with the IAM User credentials
sts = Aws::STS::Client.new(
  access_key_id: ENV["AWS_ACCESS_KEY_ID"],
  secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
  region: "us-east-1"
)

# Step 4b: Assume the Polly Role
role_creds = sts.assume_role(
  role_arn: ENV["AWS_POLLY_ROLE_ARN"],
  role_session_name: "bingo"
).credentials

# Step 4c: Create Polly client with temporary credentials
polly = Aws::Polly::Client.new(
  access_key_id: role_creds.access_key_id,
  secret_access_key: role_creds.secret_access_key,
  session_token: role_creds.session_token,
  region: "us-east-1"
)

VOICES = {
  "en" => "Danielle",
  "pt-BR" => "Camila"
}.freeze

BINGO_PHRASES = {
  "en" => [
    "<speak>Next number is</speak>",
    "<speak>Coming up next</speak>",
    "<speak>The next draw is</speak>",
    "<speak>Here comes the next number</speak>",
    "<speak>Let's see the next number</speak>",
    "<speak>And the next number is</speak>",
    "<speak>Get ready for the next number</speak>",
    "<speak>Alright, here we go</speak>",
    "<speak>Number coming up</speak>",
    "<speak>Eyes on the board — next number</speak>",
    "<speak>Drumroll please… the next number is</speak>",
    "<speak>Let's find out the next number</speak>",
    "<speak>Who needs this one? Next number</speak>",
    "<speak>Cross your fingers… next number is</speak>",
    "<speak>This could be a good one… next number</speak>",
    "<speak>Pay attention — next number</speak>",
    "<speak>Hold on tight, the next number is</speak>",
    "<speak>Ready or not, here it comes</speak>",
    "<speak>Can you guess the next number?</speak>",
    "<speak>Big reveal… next number</speak>",
    "<speak>Here we go again… next number</speak>",
    "<speak>Watch closely — next number</speak>",
    "<speak>And now, the next number is</speak>",
    "<speak>Let's check the board for the next number</speak>",
    "<speak>All set? Next number coming up</speak>",
    "<speak>Time for the next number</speak>",
    "<speak>The suspense is real… next number</speak>",
    "<speak>Spotlight on the next number</speak>",
    "<speak>Attention players — next number</speak>",
    "<speak>Heads up! Next number</speak>",
    "<speak>Next in line is</speak>",
    "<speak>Brace yourselves… next number</speak>",
    "<speak>The board awaits… next number</speak>",
    "<speak>Coming right up… next number</speak>",
    "<speak>Here it is… next number</speak>",
    "<speak>Who will need this number? Next number</speak>",
    "<speak>Let's see what the board says — next number</speak>",
    "<speak>Next number coming to you</speak>",
    "<speak>Keep your eyes open… next number</speak>",
    "<speak>Don't blink — next number</speak>",
    "<speak>Time to mark your cards — next number</speak>",
    "<speak>Are you ready? Next number</speak>",
    "<speak>Let's reveal the next number</speak>",
    "<speak>Next number on the board is</speak>",
    "<speak>Check your cards — next number</speak>",
    "<speak>Here comes another one… next number</speak>",
    "<speak>And now, number time!</speak>",
    "<speak>The next lucky number is</speak>",
    "<speak>Next one could be yours… number</speak>",
    "<speak>Spot your next number</speak>",
    "<speak>Number reveal coming up</speak>",
    "<speak>Eyes front… next number</speak>",
    "<speak>Next number, don't miss it</speak>"
  ],
  "pt-BR" => [
    "<speak>O próximo número é</speak>",
    "<speak>Vindo a seguir</speak>",
    "<speak>O próximo sorteado é</speak>",
    "<speak>Aqui vem o próximo número</speak>",
    "<speak>Vamos ver o próximo número</speak>",
    "<speak>E o próximo número é</speak>",
    "<speak>Prepare-se para o próximo número</speak>",
    "<speak>Vamos lá</speak>",
    "<speak>Número chegando</speak>",
    "<speak>Olhos no quadro — próximo número</speak>",
    "<speak>Por favor, batam palmas… o próximo número é</speak>",
    "<speak>Vamos descobrir o próximo número</speak>",
    "<speak>Quem precisa deste? Próximo número</speak>",
    "<speak>Crucem os dedos… o próximo número é</speak>",
    "<speak>Pode ser um bom… próximo número</speak>",
    "<speak>Preste atenção — próximo número</speak>",
    "<speak>Segure firme, o próximo número é</speak>",
    "<speak>Pronto ou não, aqui vem</speak>",
    "<speak>Consegue adivinhar o próximo número?</speak>",
    "<speak>Grande revelação… próximo número</speak>",
    "<speak>Lá vamos nós novamente… próximo número</speak>",
    "<speak>Observe atentamente — próximo número</speak>",
    "<speak>E agora, o próximo número é</speak>",
    "<speak>Vamos conferir o quadro para o próximo número</speak>",
    "<speak>Todos prontos? Próximo número chegando</speak>",
    "<speak>Hora do próximo número</speak>",
    "<speak>A tensão aumenta… próximo número</speak>",
    "<speak>Spotlight no próximo número</speak>",
    "<speak>Atenção jogadores — próximo número</speak>",
    "<speak>Olhos abertos! Próximo número</speak>",
    "<speak>O próximo na fila é</speak>",
    "<speak>Preparem-se… próximo número</speak>",
    "<speak>O quadro espera… próximo número</speak>",
    "<speak>Chegando já… próximo número</speak>",
    "<speak>Aqui está… próximo número</speak>",
    "<speak>Quem vai precisar deste? Próximo número</speak>",
    "<speak>Vamos ver o que o quadro diz — próximo número</speak>",
    "<speak>Próximo número chegando até você</speak>",
    "<speak>Mantenha os olhos abertos… próximo número</speak>",
    "<speak>Não pisque — próximo número</speak>",
    "<speak>Hora de marcar seus cartões — próximo número</speak>",
    "<speak>Pronto? Próximo número</speak>",
    "<speak>Vamos revelar o próximo número</speak>",
    "<speak>O próximo número no quadro é</speak>",
    "<speak>Confira seus cartões — próximo número</speak>",
    "<speak>Chegou mais um… próximo número</speak>",
    "<speak>E agora, é hora do número!</speak>",
    "<speak>O próximo número da sorte é</speak>",
    "<speak>O próximo pode ser seu… número</speak>",
    "<speak>Encontre seu próximo número</speak>",
    "<speak>Revelação do número chegando</speak>",
    "<speak>Olhos à frente… próximo número</speak>",
    "<speak>Próximo número, não perca</speak>"
  ]
}

def generate_speech(polly, file, text, language)
  resp = polly.synthesize_speech(
    engine: "generative",
    output_format: "mp3",
    text_type: "ssml",
    text: text,
    voice_id: VOICES[language]
  )

  File.open("app/assets/audios/#{language}/#{VOICES[language]}/#{file}", "wb") { |f| f.write(resp.audio_stream.read) }
end

numbers = (1..75).map do |i|
  if i <= 15
    { file: "b#{i}.mp3", text: "<speak>B #{i}</speak>" }
  elsif i <= 30
    { file: "i#{i}.mp3", text: "<speak>I #{i}</speak>" }
  elsif i <= 45
    { file: "n#{i}.mp3", text: "<speak>N #{i}</speak>" }
  elsif i <= 60
    { file: "g#{i}.mp3", text: "<speak>G #{i}</speak>" }
  else
    { file: "o#{i}.mp3", text: "<speak>O #{i}</speak>" }
  end
end

numbers.each do |number|
  puts "Generating #{number[:file]} in en and pt-BR"
  generate_speech(polly, number[:file], number[:text], "en")
  generate_speech(polly, number[:file], number[:text], "pt-BR")
end

BINGO_PHRASES["en"].each_with_index do |phrase, index|
  puts "Generating phrase#{index}.mp3 in en"
  generate_speech(polly, "phrase#{index}.mp3", phrase, "en")
end

BINGO_PHRASES["pt-BR"].each_with_index do |phrase, index|
  puts "Generating phrase#{index}.mp3 in pt-BR"
  generate_speech(polly, "phrase#{index}.mp3", phrase, "pt-BR")
end
