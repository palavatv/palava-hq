PalavaHq::Application.routes.draw do
  scope 'plv' do
    resources :potentials, only: [:create]
    resources :feedback_entries, path: 'feedback', only: [:create]

    controller :potentials do
      get 'confirm/:confirmation_token',    action: :update,  as: :update_potential
      get 'unsubscribe/:unsubscribe_token', action: :destroy, as: :destroy_potential
    end

    get 'ping' => proc { [200, {}, ['OK']] }
  end

  get '*path' => redirect{ |params, req|
    query = req.query_string.present? ? "?#{req.query_string}" : ""
    "/#/#{params[:path]}#{query}"
  }
end
