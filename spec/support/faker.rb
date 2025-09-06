require 'faker'

# RSpecの実行前に一度だけ、Fakerのロケールを日本語に設定する
RSpec.configure do |config|
  config.before(:suite) do
    Faker::Config.locale = :ja
  end
end
