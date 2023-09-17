# class Users::RegistrationsController < Devise::RegistrationsController
#   # ...

#   # Première étape : Créer le compte avec email et mot de passe
#   def create
#     # Appeler la méthode parente pour gérer la création de base de Devise
#     super do |resource|
#       if resource.persisted?
#         # Si l'utilisateur a été créé avec succès lors de la première connexion,
#         # redirigez-le vers la deuxième étape pour compléter son profil.
#         sign_in(resource) # Connectez automatiquement l'utilisateur
#         redirect_to gardens_path(resource)
#         return
#       end
#     end
#   end

#   # Deuxième étape : Compléter le profil
#   def edit_profile
#     @user = current_user
#     render :edit_profile
#     # Affichez ici le formulaire pour compléter les champs de profil restants
#   end

#   def update_profile
#     @user = current_user
#     if @user.update(profile_params)
#       redirect_to edit_user_profile_path(@user), notice: 'Profil mis à jour avec succès.'

#       # Redirigez l'utilisateur vers une page de confirmation ou toute autre page pertinente
#       # redirect_to users_edit_profile_path(@user)
#     else
#       # En cas d'erreurs de validation, affichez à nouveau le formulaire d'édition
#       render :edit_profile
#     end
#   end

#   private

#   def profile_params
#     params.require(:user).permit(:telephone, :nom, :prenom, :adresse_ville, :adresse_type_voie, :adresse_nom_voie, :adresse_numero, :adresse_code_postal, :adresse_infos_complementaires_1, :adresse_infos_complementaires_2)
#   end
# end
