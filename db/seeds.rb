#Spree::Core::Engine.load_seed if defined?(Spree::Core)
#Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

def store_count(s_index, min_count, max_count, rand_count)
  if s_index == 0
    max_count
  elsif s_index == 1
    min_count
  else
    rand_count
  end
end

def product_count(s_index, p_index, min_count, max_count, rand_count)
  if s_index == 0
    if p_index == 0
      max_count
    elsif p_index == 1
      min_count
    else
      rand_count
    end
  else
    rand_count
  end
end

#Update the Home Store details
store = Spree::Store.find(1)
if store.meta_keywords == 'natty'
  puts 'Aborting! Seed already attempted. Please reset all migrations and then re-seed.'
else
  store.update!(name: 'Natty', url: 'natty.elasticbeanstalk.com', meta_description: 'Natty', meta_keywords: 'natty', seo_title: 'Natty', mail_from_address: 'noreply@concretelabs.co', default_currency: 'INR', code: 'admin')

  #Add Taxonomies
  puts 'Creating Taxonomies'
  taxonomies = ['categories', 'brand', 'nattypick', 'sale']
  taxonomies.each {|t| Spree::Taxonomy.create(name: t)}

  #Add Level 1 Categories
  categories_id = Spree::Taxonomy.where(name: 'categories').first.id
  Spree::Taxon.create!(name: "women", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Women", meta_keywords: "women")
  Spree::Taxon.create!(name: "men", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Men", meta_keywords: "men")
  Spree::Taxon.create!(name: "kids", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Kids", meta_keywords: "kids")
  Spree::Taxon.create!(name: "home", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Home", meta_keywords: "home")
  Spree::Taxon.create!(name: "lifestyle", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Lifestyle", meta_keywords: "lifestyle")
  Spree::Taxon.create!(name: "food & drink", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Food and Drink", meta_keywords: "food, drink")
  Spree::Taxon.create!(name: "gifts", parent_id: categories_id, taxonomy_id: categories_id, meta_description: "Gifts", meta_keywords: "gifts")

  #Add Level 2 Categories
  women_id = Spree::Taxon.where(name: 'women').first.id
  Spree::Taxon.create!(name: "apparel", parent_id: women_id, taxonomy_id: categories_id, meta_description: "Apparel", meta_keywords: "apparel")
  Spree::Taxon.create!(name: "accessories", parent_id: women_id, taxonomy_id: categories_id, meta_description: "Accessories", meta_keywords: "accessories")
  Spree::Taxon.create!(name: "footwear", parent_id: women_id, taxonomy_id: categories_id, meta_description: "Footwear", meta_keywords: "footwear")
  Spree::Taxon.create!(name: "bags", parent_id: women_id, taxonomy_id: categories_id, meta_description: "Bags", meta_keywords: "bags")
  Spree::Taxon.create!(name: "jewellery", parent_id: women_id, taxonomy_id: categories_id, meta_description: "Jewellery", meta_keywords: "jewellery")
  Spree::Taxon.create!(name: "maternity", parent_id: women_id, taxonomy_id: categories_id, meta_description: "Maternity", meta_keywords: "maternity")
  men_id = Spree::Taxon.where(name: 'men').first.id
  Spree::Taxon.create!(name: "apparel", parent_id: men_id, taxonomy_id: categories_id, meta_description: "Apparel", meta_keywords: "apparel")
  Spree::Taxon.create!(name: "accessories", parent_id: men_id, taxonomy_id: categories_id, meta_description: "Accessories", meta_keywords: "accessories")
  Spree::Taxon.create!(name: "footwear", parent_id: men_id, taxonomy_id: categories_id, meta_description: "Footwear", meta_keywords: "footwear")
  Spree::Taxon.create!(name: "bags", parent_id: men_id, taxonomy_id: categories_id, meta_description: "Bags", meta_keywords: "bags")
  kids_id = Spree::Taxon.where(name: 'kids').first.id
  Spree::Taxon.create!(name: "apparel", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "Apparel", meta_keywords: "apparel")
  Spree::Taxon.create!(name: "accessories", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "Accessories", meta_keywords: "accessories")
  Spree::Taxon.create!(name: "footwear", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "Footwear", meta_keywords: "footwear")
  Spree::Taxon.create!(name: "toys/games", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "Toys / Games", meta_keywords: "toys, games")
  Spree::Taxon.create!(name: "school", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "School", meta_keywords: "school")
  Spree::Taxon.create!(name: "room decor", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "Room Decor", meta_keywords: "room, decor")
  Spree::Taxon.create!(name: "babies", parent_id: kids_id, taxonomy_id: categories_id, meta_description: "Babies", meta_keywords: "babies")
  home_id = Spree::Taxon.where(name: 'home').first.id
  Spree::Taxon.create!(name: "decorative accesories", parent_id: home_id, taxonomy_id: categories_id, meta_description: "Decorative Accesories", meta_keywords: "decorative, accessories")
  Spree::Taxon.create!(name: "furniture", parent_id: home_id, taxonomy_id: categories_id, meta_description: "Furniture", meta_keywords: "furniture")
  Spree::Taxon.create!(name: "lights", parent_id: home_id, taxonomy_id: categories_id, meta_description: "Lights", meta_keywords: "lights")
  Spree::Taxon.create!(name: "art", parent_id: home_id, taxonomy_id: categories_id, meta_description: "Art", meta_keywords: "art")
  Spree::Taxon.create!(name: "dining/drinking", parent_id: home_id, taxonomy_id: categories_id, meta_description: "Dining / Drinking", meta_keywords: "dining, drinking")
  Spree::Taxon.create!(name: "bed/bath", parent_id: home_id, taxonomy_id: categories_id, meta_description: "Bed / Bath", meta_keywords: "bed, bath")
  lifestyle_id = Spree::Taxon.where(name: 'lifestyle').first.id
  Spree::Taxon.create!(name: "stationery", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Stationary", meta_keywords: "stationary")
  Spree::Taxon.create!(name: "tech accessories", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Tech Accessories", meta_keywords: "tech, accessories")
  Spree::Taxon.create!(name: "travel accessories", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Travel Accessories", meta_keywords: "travel, accessories")
  Spree::Taxon.create!(name: "books/games", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Books / Games", meta_keywords: "books, games")
  Spree::Taxon.create!(name: "upcycled", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Upcycled", meta_keywords: "upcycled")
  Spree::Taxon.create!(name: "sports", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Sports", meta_keywords: "sports")
  Spree::Taxon.create!(name: "pets", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Pets", meta_keywords: "pets")
  Spree::Taxon.create!(name: "party planning", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Party Planning", meta_keywords: "party, planning")
  Spree::Taxon.create!(name: "others", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Others", meta_keywords: "others")
  Spree::Taxon.create!(name: "religious", parent_id: lifestyle_id, taxonomy_id: categories_id, meta_description: "Religious", meta_keywords: "religious")
  food_id = Spree::Taxon.where(name: 'food & drink').first.id
  Spree::Taxon.create!(name: "tea/coffee", parent_id: food_id, taxonomy_id: categories_id, meta_description: "Tea / Coffee", meta_keywords: "tea, coffee")
  Spree::Taxon.create!(name: "pickles/dips", parent_id: food_id, taxonomy_id: categories_id, meta_description: "Pickles / Dips", meta_keywords: "pickles, dips")
  Spree::Taxon.create!(name: "confectionary", parent_id: food_id, taxonomy_id: categories_id, meta_description: "Confectionary", meta_keywords: "confectionary")
  gifts_id = Spree::Taxon.where(name: 'gifts').first.id
  Spree::Taxon.create!(name: "for him", parent_id: gifts_id, taxonomy_id: categories_id, meta_description: "For Him", meta_keywords: "for, him")
  Spree::Taxon.create!(name: "for her", parent_id: gifts_id, taxonomy_id: categories_id, meta_description: "For Her", meta_keywords: "for, her")
  Spree::Taxon.create!(name: "for kids", parent_id: gifts_id, taxonomy_id: categories_id, meta_description: "For Kids", meta_keywords: "for, kids")
  Spree::Taxon.create!(name: "for babies", parent_id: gifts_id, taxonomy_id: categories_id, meta_description: "For Babies", meta_keywords: "for, babies")
  Spree::Taxon.create!(name: "by personality", parent_id: gifts_id, taxonomy_id: categories_id, meta_description: "By Personality", meta_keywords: "by, personality")
  Spree::Taxon.create!(name: "by occasion", parent_id: gifts_id, taxonomy_id: categories_id, meta_description: "By Occasion", meta_keywords: "by, occasion")

  #Add Level 3 Categories
  women_apparel_id = Spree::Taxon.where(name: 'apparel', parent_id: women_id).first.id
  Spree::Taxon.create!(name: "sarees", parent_id: women_apparel_id, taxonomy_id: categories_id, meta_description: "Sarees", meta_keywords: "sarees")
  Spree::Taxon.create!(name: "t-shirts", parent_id: women_apparel_id, taxonomy_id: categories_id, meta_description: "T-shirts", meta_keywords: "tshirts")
  Spree::Taxon.create!(name: "kurtas", parent_id: women_apparel_id, taxonomy_id: categories_id, meta_description: "Kurtas", meta_keywords: "kurtas")
  Spree::Taxon.create!(name: "sleepwear", parent_id: women_apparel_id, taxonomy_id: categories_id, meta_description: "Sleepwear", meta_keywords: "sleepwear")
  Spree::Taxon.create!(name: "swimwear", parent_id: women_apparel_id, taxonomy_id: categories_id, meta_description: "Swimwear", meta_keywords: "swimwear")
  women_accessories_id = Spree::Taxon.where(name: 'accessories', parent_id: women_id).first.id
  Spree::Taxon.create!(name: "scarves", parent_id: women_accessories_id, taxonomy_id: categories_id, meta_description: "Scarves", meta_keywords: "scarves")
  Spree::Taxon.create!(name: "hair accessories", parent_id: women_accessories_id, taxonomy_id: categories_id, meta_description: "Hair Accessories", meta_keywords: "hair, accessories")
  Spree::Taxon.create!(name: "umbrellas", parent_id: women_accessories_id, taxonomy_id: categories_id, meta_description: "Umbrellas", meta_keywords: "umbrellas")
  women_maternity_id = Spree::Taxon.where(name: 'maternity', parent_id: women_id).first.id
  Spree::Taxon.create!(name: "apparel", parent_id: women_maternity_id, taxonomy_id: categories_id, meta_description: "Apparel", meta_keywords: "apparel")
  Spree::Taxon.create!(name: "accessories", parent_id: women_maternity_id, taxonomy_id: categories_id, meta_description: "Accessories", meta_keywords: "accessories")
  men_accessories_id = Spree::Taxon.where(name: 'accessories', parent_id: men_id).first.id
  Spree::Taxon.create!(name: "ties", parent_id: men_accessories_id, taxonomy_id: categories_id, meta_description: "Ties", meta_keywords: "ties")
  Spree::Taxon.create!(name: "bowties", parent_id: men_accessories_id, taxonomy_id: categories_id, meta_description: "Bowties", meta_keywords: "bowties")
  Spree::Taxon.create!(name: "cufflinks", parent_id: men_accessories_id, taxonomy_id: categories_id, meta_description: "Cufflinks", meta_keywords: "cufflinks")
  Spree::Taxon.create!(name: "belts", parent_id: men_accessories_id, taxonomy_id: categories_id, meta_description: "Belts", meta_keywords: "belts")
  Spree::Taxon.create!(name: "pocket squares", parent_id: men_accessories_id, taxonomy_id: categories_id, meta_description: "Pocket Squares", meta_keywords: "pocket, squares")
  kids_apparel_id = Spree::Taxon.where(name: 'apparel', parent_id: kids_id).first.id
  Spree::Taxon.create!(name: "boys", parent_id: kids_apparel_id, taxonomy_id: categories_id, meta_description: "Boys", meta_keywords: "boys")
  Spree::Taxon.create!(name: "girls", parent_id: kids_apparel_id, taxonomy_id: categories_id, meta_description: "Girls", meta_keywords: "girls")
  kids_toys_id = Spree::Taxon.where(name: 'toys/games', parent_id: kids_id).first.id
  Spree::Taxon.create!(name: "stuffed animals", parent_id: kids_toys_id, taxonomy_id: categories_id, meta_description: "Stuffed Animals", meta_keywords: "stuffed, animals")
  Spree::Taxon.create!(name: "educational games", parent_id: kids_toys_id, taxonomy_id: categories_id, meta_description: "Educational Games", meta_keywords: "educational, games")
  kids_school_id = Spree::Taxon.where(name: 'school', parent_id: kids_id).first.id
  Spree::Taxon.create!(name: "bags", parent_id: kids_school_id, taxonomy_id: categories_id, meta_description: "Bags", meta_keywords: "bags")
  Spree::Taxon.create!(name: "boxes", parent_id: kids_school_id, taxonomy_id: categories_id, meta_description: "Boxes", meta_keywords: "boxes")
  Spree::Taxon.create!(name: "labels", parent_id: kids_school_id, taxonomy_id: categories_id, meta_description: "Labels", meta_keywords: "labels")
  Spree::Taxon.create!(name: "notebooks", parent_id: kids_school_id, taxonomy_id: categories_id, meta_description: "Notebooks", meta_keywords: "notebooks")
  home_decorative_id = Spree::Taxon.where(name: 'decorative accesories', parent_id: home_id).first.id
  Spree::Taxon.create!(name: "cushions", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Cushions", meta_keywords: "cushions")
  Spree::Taxon.create!(name: "photo frames", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Photo Frames", meta_keywords: "photo, frames")
  Spree::Taxon.create!(name: "candles", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Candles", meta_keywords: "candles")
  Spree::Taxon.create!(name: "clocks", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Clocks", meta_keywords: "clocks")
  Spree::Taxon.create!(name: "vases", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Vases", meta_keywords: "vases")
  Spree::Taxon.create!(name: "rugs", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Rugs", meta_keywords: "rugs")
  Spree::Taxon.create!(name: "doormats", parent_id: home_decorative_id, taxonomy_id: categories_id, meta_description: "Doormats", meta_keywords: "doormats")
  home_art_id = Spree::Taxon.where(name: 'art', parent_id: home_id).first.id
  Spree::Taxon.create!(name: "prints", parent_id: home_art_id, taxonomy_id: categories_id, meta_description: "Prints", meta_keywords: "prints")
  Spree::Taxon.create!(name: "paintings", parent_id: home_art_id, taxonomy_id: categories_id, meta_description: "paintings", meta_keywords: "paintings")
  Spree::Taxon.create!(name: "photographs", parent_id: home_art_id, taxonomy_id: categories_id, meta_description: "photographs", meta_keywords: "photographs")
  Spree::Taxon.create!(name: "sculpture", parent_id: home_art_id, taxonomy_id: categories_id, meta_description: "sculpture", meta_keywords: "sculpture")
  Spree::Taxon.create!(name: "pottery", parent_id: home_art_id, taxonomy_id: categories_id, meta_description: "pottery", meta_keywords: "pottery")
  home_dining_id = Spree::Taxon.where(name: 'dining/drinking', parent_id: home_id).first.id
  Spree::Taxon.create!(name: "glassware", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "Glassware", meta_keywords: "glassware")
  Spree::Taxon.create!(name: "tableware", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "tableware", meta_keywords: "tableware")
  Spree::Taxon.create!(name: "trays", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "Trays", meta_keywords: "trays")
  Spree::Taxon.create!(name: "coasters", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "Coasters", meta_keywords: "coasters")
  Spree::Taxon.create!(name: "placemats", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "Placemats", meta_keywords: "placemats")
  Spree::Taxon.create!(name: "table linen", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "Table Linen", meta_keywords: "table, linen")
  Spree::Taxon.create!(name: "kitchen storage", parent_id: home_dining_id, taxonomy_id: categories_id, meta_description: "Kitchen Storage", meta_keywords: "kitchen, storage")
  home_bed_id = Spree::Taxon.where(name: 'bed/bath', parent_id: home_id).first.id
  Spree::Taxon.create!(name: "bed linen", parent_id: home_bed_id, taxonomy_id: categories_id, meta_description: "Bed Linen", meta_keywords: "bed, linen")
  Spree::Taxon.create!(name: "towels", parent_id: home_bed_id, taxonomy_id: categories_id, meta_description: "Towels", meta_keywords: "towels")
  Spree::Taxon.create!(name: "candles", parent_id: home_bed_id, taxonomy_id: categories_id, meta_description: "Candles", meta_keywords: "candles")
  Spree::Taxon.create!(name: "bottle covers", parent_id: home_bed_id, taxonomy_id: categories_id, meta_description: "Bottle Covers", meta_keywords: "bottle, covers")
  Spree::Taxon.create!(name: "beauty", parent_id: home_bed_id, taxonomy_id: categories_id, meta_description: "Beauty", meta_keywords: "beauty")
  lifestyle_stationery_id = Spree::Taxon.where(name: 'stationery', parent_id: lifestyle_id).first.id
  Spree::Taxon.create!(name: "notebooks", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "Notebooks", meta_keywords: "notebooks")
  Spree::Taxon.create!(name: "cards", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "cards", meta_keywords: "cards")
  Spree::Taxon.create!(name: "stationery", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "stationery", meta_keywords: "stationery")
  Spree::Taxon.create!(name: "gift wrap", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "Gift Wrap", meta_keywords: "gift, wrap")
  Spree::Taxon.create!(name: "gift bags", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "Gift Bags", meta_keywords: "gift, bags")
  lifestyle_tech_id = Spree::Taxon.where(name: 'tech accessories', parent_id: lifestyle_id).first.id
  Spree::Taxon.create!(name: "tech cases", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "Tech Cases", meta_keywords: "tech, cases")
  Spree::Taxon.create!(name: "skins", parent_id: lifestyle_stationery_id, taxonomy_id: categories_id, meta_description: "skins", meta_keywords: "skins")
  lifestyle_travel_id = Spree::Taxon.where(name: 'travel accessories', parent_id: lifestyle_id).first.id
  Spree::Taxon.create!(name: "luggage tags", parent_id: lifestyle_travel_id, taxonomy_id: categories_id, meta_description: "Luggage Tags", meta_keywords: "luggage, tags")
  Spree::Taxon.create!(name: "travel bags", parent_id: lifestyle_travel_id, taxonomy_id: categories_id, meta_description: "Travel Bags", meta_keywords: "travel, bags")
  lifestyle_party_id = Spree::Taxon.where(name: 'party planning', parent_id: lifestyle_id).first.id
  Spree::Taxon.create!(name: "party supplies", parent_id: lifestyle_party_id, taxonomy_id: categories_id, meta_description: "Party Supplies", meta_keywords: "party, supplies")
  Spree::Taxon.create!(name: "decor", parent_id: lifestyle_party_id, taxonomy_id: categories_id, meta_description: "Decor", meta_keywords: "decor")
  Spree::Taxon.create!(name: "invites", parent_id: lifestyle_party_id, taxonomy_id: categories_id, meta_description: "Invites", meta_keywords: "invites")
  Spree::Taxon.create!(name: "photobooth props", parent_id: lifestyle_party_id, taxonomy_id: categories_id, meta_description: "Photobooth Props", meta_keywords: "photobooth, props")
  lifestyle_others_id = Spree::Taxon.where(name: 'others', parent_id: lifestyle_id).first.id
  Spree::Taxon.create!(name: "vintage typewriters", parent_id: lifestyle_others_id, taxonomy_id: categories_id, meta_description: "Vintage Typewriters", meta_keywords: "vintage, typewriters")
  Spree::Taxon.create!(name: "walking sticks", parent_id: lifestyle_others_id, taxonomy_id: categories_id, meta_description: "Walking Sticks", meta_keywords: "walking, sticks")
  Spree::Taxon.create!(name: "hookahs", parent_id: lifestyle_others_id, taxonomy_id: categories_id, meta_description: "Hookahs", meta_keywords: "hookahs")
  Spree::Taxon.create!(name: "gardening", parent_id: lifestyle_others_id, taxonomy_id: categories_id, meta_description: "Gardening", meta_keywords: "gardening")
  food_tea_id = Spree::Taxon.where(name: 'tea/coffee', parent_id: food_id).first.id
  Spree::Taxon.create!(name: "tea", parent_id: food_tea_id, taxonomy_id: categories_id, meta_description: "Tea", meta_keywords: "tea")
  Spree::Taxon.create!(name: "coffee", parent_id: food_tea_id, taxonomy_id: categories_id, meta_description: "Coffee", meta_keywords: "coffee")
  food_pickles_id = Spree::Taxon.where(name: 'pickles/dips', parent_id: food_id).first.id
  Spree::Taxon.create!(name: "dips", parent_id: food_pickles_id, taxonomy_id: categories_id, meta_description: "Dips", meta_keywords: "dips")
  Spree::Taxon.create!(name: "sauces", parent_id: food_pickles_id, taxonomy_id: categories_id, meta_description: "Sauces", meta_keywords: "sauces")
  Spree::Taxon.create!(name: "pickles", parent_id: food_pickles_id, taxonomy_id: categories_id, meta_description: "Pickles", meta_keywords: "pickles")
  Spree::Taxon.create!(name: "butters", parent_id: food_pickles_id, taxonomy_id: categories_id, meta_description: "Butters", meta_keywords: "butters")
  Spree::Taxon.create!(name: "jams", parent_id: food_pickles_id, taxonomy_id: categories_id, meta_description: "Jams", meta_keywords: "jams")
  Spree::Taxon.create!(name: "condiments", parent_id: food_pickles_id, taxonomy_id: categories_id, meta_description: "Condiments", meta_keywords: "condiments")
  food_confectionary_id = Spree::Taxon.where(name: 'confectionary', parent_id: food_id).first.id
  Spree::Taxon.create!(name: "baked goods", parent_id: food_confectionary_id, taxonomy_id: categories_id, meta_description: "Baked Goods", meta_keywords: "baked, goods")
  Spree::Taxon.create!(name: "granola", parent_id: food_confectionary_id, taxonomy_id: categories_id, meta_description: "Granola", meta_keywords: "granola")
  Spree::Taxon.create!(name: "chocolates", parent_id: food_confectionary_id, taxonomy_id: categories_id, meta_description: "Chocolates", meta_keywords: "chocolates")
  gifts_personality_id = Spree::Taxon.where(name: 'by personality', parent_id: gifts_id).first.id
  Spree::Taxon.create!(name: "the fashionista", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Fashionista", meta_keywords: "the, fashionista")
  Spree::Taxon.create!(name: "the dapper gentleman", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Dapper Gentleman", meta_keywords: "the, dapper, gentleman")
  Spree::Taxon.create!(name: "the environmentalist", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Environmentalist", meta_keywords: "the, environmentalist")
  Spree::Taxon.create!(name: "the pet lover", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Pet Lover", meta_keywords: "the, pet, lover")
  Spree::Taxon.create!(name: "the foodie", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Foodie", meta_keywords: "the, foodie")
  Spree::Taxon.create!(name: "the traveler", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Traveler", meta_keywords: "the, traveler")
  Spree::Taxon.create!(name: "the artist", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Artist", meta_keywords: "the, artist")
  Spree::Taxon.create!(name: "the perfect hostess", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Perfect Hostess", meta_keywords: "the, perfect, hostess")
  Spree::Taxon.create!(name: "the design aficionado", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The Design Aficionado", meta_keywords: "the, design, aficionado")
  Spree::Taxon.create!(name: "the one who has everything", parent_id: gifts_personality_id, taxonomy_id: categories_id, meta_description: "The One Who Has Everything", meta_keywords: "the, one, who, has, everything")
  gifts_occasion_id = Spree::Taxon.where(name: 'by occasion', parent_id: gifts_id).first.id
  Spree::Taxon.create!(name: "birthday", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Birthday", meta_keywords: "birthday")
  Spree::Taxon.create!(name: "anniversary", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Anniversary", meta_keywords: "anniversary")
  Spree::Taxon.create!(name: "weddings", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Weddings", meta_keywords: "weddings")
  Spree::Taxon.create!(name: "bridal showers", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Bridal Showers", meta_keywords: "bridal, showers")
  Spree::Taxon.create!(name: "bachelor parties", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Bachelor Parties", meta_keywords: "bachelor, parties")
  Spree::Taxon.create!(name: "bachelorette parties", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Bachelorette Parties", meta_keywords: "bachelorette, parties")
  Spree::Taxon.create!(name: "new baby", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "New Baby", meta_keywords: "new, baby")
  Spree::Taxon.create!(name: "baby showers", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Baby Showers", meta_keywords: "baby, showers")
  Spree::Taxon.create!(name: "housewarming", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Housewarming", meta_keywords: "housewarming")
  Spree::Taxon.create!(name: "seasonal", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Seasonal", meta_keywords: "seasonal")
  Spree::Taxon.create!(name: "just because", parent_id: gifts_occasion_id, taxonomy_id: categories_id, meta_description: "Just Because", meta_keywords: "just, because")

  #Add Countries and States
  puts 'Creating Countries and States'
  india = Spree::Country.create!(name: 'India', iso_name: 'INDIA', states_required: true)
  india.states << Spree::State.new(name: 'Andaman and Nicobar Islands', abbr: 'AN')
  india.states << Spree::State.new(name: 'Andhra Pradesh', abbr: 'AP')
  india.states << Spree::State.new(name: 'Arunachal Pradesh', abbr: 'AR')
  india.states << Spree::State.new(name: 'Assam', abbr: 'AS')
  india.states << Spree::State.new(name: 'Bihar', abbr: 'BR')
  india.states << Spree::State.new(name: 'Chandigarh', abbr: 'CH')
  india.states << Spree::State.new(name: 'Chhattisgarh', abbr: 'CT')
  india.states << Spree::State.new(name: 'Dadra and Nagar Haveli', abbr: 'DN')
  india.states << Spree::State.new(name: 'Daman and Diu', abbr: 'DD')
  india.states << Spree::State.new(name: 'Delhi', abbr: 'DL')
  india.states << Spree::State.new(name: 'Goa', abbr: 'GA')
  india.states << Spree::State.new(name: 'Gujarat', abbr: 'GJ')
  india.states << Spree::State.new(name: 'Haryana', abbr: 'HR')
  india.states << Spree::State.new(name: 'Himachal Pradesh', abbr: 'HP')
  india.states << Spree::State.new(name: 'Jammu and Kashmir', abbr: 'JK')
  india.states << Spree::State.new(name: 'Jharkhand', abbr: 'JH')
  india.states << Spree::State.new(name: 'Karnataka', abbr: 'KA')
  india.states << Spree::State.new(name: 'Kerala', abbr: 'KL')
  india.states << Spree::State.new(name: 'Lakshadweep', abbr: 'LD')
  india.states << Spree::State.new(name: 'Madhya Pradesh', abbr: 'MP')
  india.states << Spree::State.new(name: 'Maharashtra', abbr: 'MH')
  india.states << Spree::State.new(name: 'Manipur', abbr: 'MN')
  india.states << Spree::State.new(name: 'Meghalaya', abbr: 'ML')
  india.states << Spree::State.new(name: 'Mizoram', abbr: 'MZ')
  india.states << Spree::State.new(name: 'Nagaland', abbr: 'NL')
  india.states << Spree::State.new(name: 'Odisha', abbr: 'OR')
  india.states << Spree::State.new(name: 'Puducherry', abbr: 'PY')
  india.states << Spree::State.new(name: 'Punjab', abbr: 'PB')
  india.states << Spree::State.new(name: 'Rajasthan', abbr: 'RJ')
  india.states << Spree::State.new(name: 'Sikkim', abbr: 'SK')
  india.states << Spree::State.new(name: 'Tamil Nadu', abbr: 'TN')
  india.states << Spree::State.new(name: 'Telangana', abbr: 'TG')
  india.states << Spree::State.new(name: 'Tripura', abbr: 'TR')
  india.states << Spree::State.new(name: 'Uttarakhand', abbr: 'UT')
  india.states << Spree::State.new(name: 'Uttar Pradesh', abbr: 'UP')
  india.states << Spree::State.new(name: 'West Bengal', abbr: 'WB')

  #Create Shipping Zones & Methods
  puts 'Creating Zones and Shipping Methods'
  Spree::Zone.create!(name: "India", description: "India", default_tax: true, kind: "country", country_ids: Spree::Country.where(name: "India").pluck(:id))
  Spree::ShippingMethod.create!(name:"Default", shipping_categories: Spree::ShippingCategory.where(name: "Default"), zones: Spree::Zone.where(name: "India"), calculator_type: "Spree::Calculator::Shipping::FlatRate")

  #Setting up Payment Gateway
  puts 'Setting up Payment Gateway'
  pg = Spree::Gateway::PayuIn.create!(name: 'PayU India', description: 'PayU India', active: true, display_on: 'both', auto_capture: 'f')
  Spree::Store.first.payment_methods << pg

  #Create Roles
  puts 'Creating Roles'
  roles = ["user", "store_admin", "admin"]
  roles.each do |r|
    Spree::Role.create(name: r)
  end

  #Create Super Admin
  puts 'Creating Super Admin'
  superadmin_user = Spree::User.new(
    first_name: 'Neil',
    last_name: 'Deshpande',
    email: 'neil@concretelabs.co',
    password: 'nattyneil',
    password_confirmation: 'nattyneil',
    confirmation_sent_at: Time.zone.now,
    confirmed_at: Time.zone.now
  )
  superadmin_user.spree_roles << Spree::Role.find_by(name: 'admin')
  superadmin_user.skip_confirmation_notification!
  superadmin_user.save!
  superadmin_user.generate_spree_api_key!

  superadmin_user = Spree::User.new(
    first_name: 'Rasool',
    last_name: 'Khan',
    email: 'rasool@natty.in',
    password: 'rasool',
    password_confirmation: 'rasool',
    confirmation_sent_at: Time.zone.now,
    confirmed_at: Time.zone.now
  )
  superadmin_user.spree_roles << Spree::Role.find_by(name: 'admin')
  superadmin_user.skip_confirmation_notification!
  superadmin_user.save!
  superadmin_user.generate_spree_api_key!

  if Rails.env.development?

    #create sellers and their stores accounts
    taxon_ids = Spree::Taxonomy.where(name: 'categories').first.taxons.where('depth > 1').order('id ASC').pluck(:id)
    puts 'Creating Sellers:'
    100.times do |n|
      puts n
      user = Spree::User.new(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'helloworld',
        password_confirmation: 'helloworld',
        confirmation_sent_at: Time.zone.now,
        confirmed_at: Time.zone.now
      )
      user.spree_roles << Spree::Role.find_by_name("user")
      user.spree_roles << Spree::Role.find_by_name("store_admin")
      user.save!

      # Create Store
      name = Faker::Company.name
      store = Spree::Store.new
      store.name = Faker::Product.brand
      store.code = (Spree::Store.last.id + 1).to_s
      store.url = "default"
      store.mail_from_address = "support@natty.in"
      store.description = Faker::HipsterIpsum.paragraph
      store.featured = rand(2) == 0 ? false : true
      store.logo = Spree::ImageLogo.new(attachment: File.new('test/fixtures/images/logo/' + (rand(10) + 1).to_s   + '.jpg'))
      store.image = Spree::ImageBanner.new(attachment: File.new('test/fixtures/images/store/' + (rand(10) + 1).to_s   + '.jpg'))
      seller = Spree::Seller.create!(
        user: user,
        name: name,
        bank_name: Faker::Company.name,
        bank_branch: Faker::Company.name,
        bank_account_name: Faker::Name.name,
        bank_account_number: Faker::SSNSE.ssn,
        bank_ifsc: Faker::SSNSE.ssn,
        bank_pan: Faker::SSNSE.ssn,
        bank_tin: Faker::SSNSE.ssn,
        bank_vat: Faker::SSNSE.ssn
      )
      store.seller = seller
      address = Spree::Address.new(
        firstname: 'nil',
        lastname: 'nil',
        address1: Faker::Address.street_address,
        address2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        zipcode: Faker::AddressUS.zip_code,
        state: Spree::State.offset(rand(Spree::State.count)).first,
        country: Spree::Country.first,
        phone: Faker::PhoneNumber.phone_number,
      )
      store.office_address = Spree::UserAddress.create!(user: user, address: address, default: true, archived: false)
      store.save!
      store.sample_taxons = Spree::Taxonomy.where(name: 'categories').first.taxons.where(depth: 1).order('id ASC').sample(rand(5))
      social_urls = []
      3.times do
        if rand(2) == 1
          social_urls << Faker::Internet.http_url
        else
          social_urls << ""
        end
      end
      store.social_urls = social_urls.join(",")
      (rand(4)).times do
        sample = Spree::ProductSample.new
        sample.name = Faker::Product.product
        sample.description = Faker::HipsterIpsum.sentence
        sample.price = rand(10000)
        sample.image = Spree::Image.new(attachment: File.new('test/fixtures/images/product/' + (rand(10) + 1).to_s   + '.jpg'))
        store.product_samples << sample
      end
      store.save!
      store.approved! unless (rand(4) == 0) && (Spree::Store.count > 3)

      if store.approved?
        # Create Option types and their values
        store_count(n, 0, 4, rand(5)).times do
          name = Faker::HipsterIpsum.word
          while Spree::OptionType.where(store: store).pluck(:name).include? name do
            name = Faker::HipsterIpsum.word
          end
          option_type = Spree::OptionType.create!(store: store, name: name, presentation: name)

          # Create option values
          store_count(n, 1, 4, 1 + rand(4)).times do
            name = Faker::HipsterIpsum.word
            while Spree::OptionValue.where(option_type: option_type).pluck(:name).include? name do
              name = Faker::HipsterIpsum.word
            end
            Spree::OptionValue.create!(option_type: option_type, name: name, presentation: name)
          end
        end

        # Create Products and their variants
        option_type_ids = Spree::OptionType.where(store: store).pluck(:id)
        store_count(n, 1, 100, 1 + rand(100)).times do |index|
          product = Spree::Product.create!(
            store: store,
            sku: Faker::IdentificationMX.rfc,
            price: rand(100000),
            name: Faker::Product.product,
            description: Faker::HipsterIpsum.sentence(10),
            available_on: Time.at(((Date.today.to_time.to_f - 1.year.ago.to_f) * rand) + 1.year.ago.to_f),
            meta_description: Faker::HipsterIpsum.sentence,
            meta_keywords: Faker::HipsterIpsum.words.join(","),
            shipping_category_id: 1,
            properties_label: Faker::HipsterIpsum.word
          )
          product.approved! unless (rand(4) == 0) && (store.products.count > 2)

          if product.approved?
            stock_item = product.master.stock_items.first
            store_stock_location = Spree::StockLocation.where(store: store).first
            if store_stock_location.present?
              stock_item.stock_location = store_stock_location
            else
              stock_item.stock_location = Spree::StockLocation.new(store: store, name: store.name, propagate_all_variants: false)
            end
            stock_item.save!
            product.taxons = Spree::Taxon.find(taxon_ids.sample(1 + rand(taxon_ids.length)))
            product.option_types = Spree::OptionType.find(option_type_ids.sample(product_count(n, index, 0, option_type_ids.length, rand(option_type_ids.length + 1))))
            product_count(n, index, 0, 10, rand(10)).times do
              name = Faker::HipsterIpsum.word
              property = Spree::Property.create!(name: name, presentation: name)
              Spree::ProductProperty.create!(product: product, property: property, value: Faker::HipsterIpsum.word)
            end
            ['eco_friendly', 'hand_crafted', 'customizable', 'exclusive', 'made_in_india'].sample(product_count(n, index, 0, 5, rand(6))).each do |spec|
              product.specifications << Spree::Specification.new(spec: spec)
            end
            product_count(n, index, 0, 10, rand(11)).times do
              product.product_features << Spree::ProductFeature.new(description_line: Faker::HipsterIpsum.sentence)
            end
            product_count(n, index, 0, 1, rand(2)).times do
              product.guide = Spree::ImageGuide.new(attachment: File.new('test/fixtures/images/product/guide/' + (rand(10) + 1).to_s   + '.jpg'))
            end

            # Create variants
            product_count(n, index, 1, 4, 1 + rand(4)).times do
              variant = Spree::Variant.create!(
                product: product,
                sku: Faker::IdentificationMX.rfc,
                price: rand(100000)
              )
              stock_item = variant.stock_items.first
              stock_item.stock_location = Spree::StockLocation.where(store: store).first
              stock_item.save!
              product.option_types.sample(product_count(n, index, 1, product.option_types.length, 1 + rand(product.option_types.length))).each do |option_type|
                variant.option_values << Spree::OptionValue.where(option_type: option_type).sample
              end
              product_count(n, index, 1, 4, 1 + rand(4)).times do
                variant.images << Spree::Image.new(attachment: File.new('test/fixtures/images/product/' + (rand(10) + 1).to_s   + '.jpg'))
              end
            end
          end
        end

        # Create Inventory
        Spree::Variant.where(product: store.products).each do |variant|
          stock_item = variant.stock_items.first
          stock_location = stock_item.stock_location
          adjustment = rand(100) - stock_item.count_on_hand
          Spree::StockItem.transaction do
            if stock_item.count_on_hand + adjustment < 0
              raise StockLocation::InvalidMovementError.new(Spree.t(:stock_not_below_zero))
            end
            stock_movement = stock_location.move(stock_item.variant, adjustment, store.seller.user)
            stock_item = stock_movement.stock_item
          end
        end
      end
    end

    #Create User buyer accounts
    puts 'Creating Buyers'
    100.times do |n|
      puts n
      user = Spree::User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'helloworld',
        password_confirmation: 'helloworld',
        confirmation_sent_at: Time.zone.now,
        confirmed_at: Time.zone.now
      )
      user.spree_roles << Spree::Role.find_by_name("user")
      user.save!

      #Create Orders
      rand(20).times do |n|

        #Create base order
        order = Spree::Order.create!(user: user, created_by: user, email: user.email)

        #Create Address
        address = Spree::Address.new(
          firstname: user.first_name,
          lastname: user.last_name,
          address1: Faker::Address.street_address,
          address2: Faker::Address.secondary_address,
          city: Faker::Address.city,
          zipcode: Faker::AddressUS.zip_code,
          state: Spree::State.offset(rand(Spree::State.count)).first,
          country: Spree::Country.first,
          phone: Faker::PhoneNumber.phone_number,
        )
        order.billing_address = address
        order.shipping_address = order.billing_address
        order.save!

        #Create Line Items
        Spree::Store.where.not(id: 1).sample(10).each do |store|
          Spree::Product.where(store: store).sample(2).each do |product|
            variants = product.variants
            variants = [product.master] unless variants.present?
            variants.sample(1 + rand(variants.count)).each do |variant|
              inventory = variant.stock_items.first.count_on_hand
              quantity = 0
              if inventory >= 10
                quantity = 1 + rand(10)
              elsif inventory > 0
                quantity = 1 + rand(inventory)
              end
              if quantity > 0
                order.line_items << Spree::LineItem.new(
                  variant: variant,
                  quantity: quantity,
                  price: variant.price * quantity,
                  currency: 'INR'
                )
              end
            end
          end
        end
        order.update!
        order.create_proposed_shipments

        #Update payment, order and shipping states
        order.update(payment_total: order.total, payment_state: "paid", state: "complete", completed_at: Time.now, shipment_state: "ready")

        #Update shipments
        order.shipments.each do |shipment|
          shipment.update(state: "ready")
          shipment.suppress_mailer = true
          shipment.ship! if rand(2) == 1
        end
      end
    end
  end
end
