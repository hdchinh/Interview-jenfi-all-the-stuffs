Rails
  .application
  .routes
  .draw do
    namespace :api do
      resources :lines, only: [:index] do
        collection { get :active }
      end

      resources :train_operators, only: %i[index create] do
        collection { post :submit_train }
      end

      resources :trains, only: %i[index create] do
        member do
          put :withdraw
          get :status
        end
      end

      resources :customers, only: [:create]
      resources :packages do
        member do
          get :status
          put :withdraw
        end
      end

      resources :post_masters do
        collection { post :process_packages }
      end
    end
  end
