Rails.application.routes.draw do
  root to: redirect('/board')

  resource :board, only: :show do
    post :reset
    get  :find
  end
end
