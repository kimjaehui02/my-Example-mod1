local new_recipes = {}

for _, recipe in pairs(data.raw["recipe"]) do
    if not recipe.category or recipe.category == "crafting" or recipe.category == "advanced-crafting" or recipe.category == "crafting-with-fluid" then
        local new_recipe_name = recipe.name .. "-scrapping"

        local new_recipe = {
            type = "recipe",
            name = new_recipe_name,
            category = "scrapping",
            energy_required = 0.5,
            enabled = true,
            hidden = true,
            ingredients = {},
            icon = "__base__/graphics/icons/list-dot.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "raw-material",
            order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
            results = {}
        }

        local function process_ingredient(ingredient)
            local amountinput = ingredient[2] or ingredient.amount
            local probabilityinput = (amountinput % 2 == 1) and 0.25 or 0.5
            amountinput = (amountinput % 2 == 1) and (amountinput / 2) or amountinput / 2

            local result = {
                name = ingredient[1] or ingredient.name,
                probability = probabilityinput,
                amount = amountinput
            }

            if ingredient[1] == "fluid" or ingredient.type == "fluid" then
                result.type = "fluid"
            end

            return result
        end

        if recipe.normal then
            new_recipe.ingredients = {{
                name = recipe.name,
                probability = 1,
                amount = 1
            }}

            for _, ingredient in ipairs(recipe.normal.ingredients) do
                table.insert(new_recipe.results, process_ingredient(ingredient))
            end
        else
            new_recipe.ingredients = {{
                name = recipe.name,
                probability = 1,
                amount = 1
            }}

            for _, ingredient in ipairs(recipe.ingredients) do
                table.insert(new_recipe.results, process_ingredient(ingredient))
            end
        end

        table.insert(new_recipes, new_recipe)
    end
end

data:extend(new_recipes)
