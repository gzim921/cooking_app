require 'rails_helper'

RSpec.describe 'Users' do
  describe 'Signing in and signing up' do
    describe 'Passing the valid parameters' do
      context 'when signin in' do
        it 'should redirect us to user profile' do
          user = create(:user)
          post_params = {
            params: {
              session: {
                email: user.email,
                password: user.password
              }
            }
          }

          post '/login', post_params

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(user_path(user))
        end
      end

      context 'when signing up' do
        it 'should redirect to user profile' do
          post_params = {
            params: {
              user: {
                first_name: 'Test',
                last_name: 'Testing',
                email: 'test@gmail.com',
                password: 'Test123!',
                password_confirmation: 'Test123!'
              } 
            }
          }

          post '/users', post_params

          user = User.last
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(user_path(user))
        end

        context 'when creating user with same email' do
          it 'should pop a flash that "Email already exists" ' do
            user = create(:user)

            post_params = {
              params: {
                user: {
                  first_name: user.first_name,
                  last_name: user.last_name,
                  email: user.email,
                  password: user.password,
                  password_confirmation: user.password
                } 
              }
            }

            post '/users', post_params

            expect(response).to render_template(:new)
            expect(response.body).to include("Email already exists.")
          end
        end
      end
    end

    describe 'Passing invalid parameters' do
      context 'when signing in' do
        it "should pop a flash that Email and password doesn't match " do
          user = create(:user)

          post_params = {
            params: {
              session: {
                email: user.email,
                password: ''
              }
            }
          }

          post '/login', post_params

          expect(response).to render_template(:new)
          expect(response.body).to include("Email and password doesn't match")
        end
      end

      context 'when signing up' do
        it '' do
          post_params = {
            params: {
              user: {
                first_name: 'Test',
                last_name: 'Testing',
                email: 'test@gmail.com',
                password: '',
                password_confirmation: ''
              } 
            }
          }

          post '/users', post_params

          expect(response).to render_template(:new)
          expect(response.body).to include('Password can&#39;t be blank')
        end
      end
    end
  end

  describe 'As logged in user' do
    let(:user) { create(:user) }

    before do
      post_params = {
        params: {
          session: {
            email: user.email,
            password: user.password
          } 
        }
      }

      post '/login', post_params
    end

    context 'when editing your profile' do
      it 'should allow to redirect to edit profile' do
        get "/users/#{user.id}/edit"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Update')
      end

      it 'should allow to update' do
        post_params = {
          params: {
            user: {
              password: user.password,
              password_confirmation: user.password
            }
          }
        }

        patch "/users/#{user.id}", post_params

        expect(response).to redirect_to(user_path(user))
      end

      it 'should not allow to redirect to edit another user' do
        user_2 = create(:user)

        get "/users/#{user_2.id}/edit"

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end

      it 'should not allow to update another user' do
        user_2 = create(:user)

        post_params = {
          params: {
            user: {
              password: user.password,
              password_confirmation: user.password
            }
          }
        }

        patch "/users/#{user_2.id}", post_params

        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You dont have permission!')
      end
    end
  end

  describe 'As not logged in user' do
    context 'when editing user' do
      it 'should not allow to redirect to edit another user' do
        user_2 = create(:user)

        get "/users/#{user_2.id}/edit"

        expect(response).to redirect_to(login_path)
        follow_redirect!
        expect(response.body).to include('You have to login!')
      end

      it 'should not allow to update another user' do
        user_2 = create(:user)

        post_params = {
          params: {
            user: {
              password: user_2.password,
              password_confirmation: user_2.password
            }
          }
        }

        patch "/users/#{user_2.id}", post_params

        expect(response).to redirect_to(login_path)
        follow_redirect!
        expect(response.body).to include('You have to login!')
      end
    end
  end
end
