FactoryBot.define do
  factory :user do
    trait :reader do
      name { "MagicS" }
      email { "nangioWah@premiergaou.ci" }
      password { "onDit1st" }
      password_confirmation { "onDit1st" }
      bio { "Fool me once, shame on you. Fool me twice...!" }
      admin { false }
    end

    trait :admin do
      name { "Princess" }
      email { "princess@premiergaou.ci" }
      password { "a11oc0NA0" }
      password_confirmation { "a11oc0NA0" }
      bio { "I want plantain NAO!" }
      admin { true }
    end
  end
end
