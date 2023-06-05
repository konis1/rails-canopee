class WishlistPlant < ApplicationRecord
  belongs_to :wishlist
  belongs_to :plant

end
