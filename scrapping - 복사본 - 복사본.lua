
-- data:extend
-- {  
  -- {
  --   type = "recipe",
  --   name = "electronic-circuit-scrapping",
  --   category = "scrapping",
  --   energy_required = 2,
  --   enabled = true,
  --   ingredients = {{"electronic-circuit", 1}},
  --   icon = "__base__/graphics/icons/electronic-circuit.png",
  --   icon_size = 64, icon_mipmaps = 4,
  --   subgroup = "raw-material",
  --   order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
  --   results =
  --   {
  --     {
  --       name = "iron-plate",
  --       probability = 0.25,
  --       amount = 1
  --     },
  --     {
  --       name = "copper-cable",
  --       probability = 0.75,
  --       amount = 1
  --     }
  --   }
  -- },
--   {
--     type = "recipe",
--     name = "transport-belt-scrapping",
--     category = "scrapping",
--     energy_required = 2,
--     enabled = true,
--     ingredients = {{"transport-belt", 1}},
--     icon = "__base__/graphics/icons/transport-belt.png",
--     icon_size = 64, icon_mipmaps = 4,
--     subgroup = "raw-material",
--     order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
--     results =
--     {
--       {
--         name = "iron-plate",
--         probability = 0.25,
--         amount = 1
--       },
--       {
--         name = "iron-gear-wheel",
--         probability = 0.25,
--         amount = 1
--       }
--     }
--   },
-- }

local new_recipes = {}
local new_recipe

for _, recipe in pairs(data.raw["recipe"]) do

  if data.raw["item"][recipe.name or ""] or data.raw["item"][recipe.result or ""] or (recipe.results and recipe.results[1] and data.raw["item"][recipe.results[1].name or ""]) then
    -- recipe.name, recipe.result, recipe.results[1]이 모두 nil일 때 스킵
    goto continue
end


  if not recipe.category or recipe.category == "crafting" or recipe.category == "advanced-crafting"  or  recipe.category == "crafting-with-fluid"  then
    local new_recipe_name = recipe.name .. "-scrapping"


    if recipe.normal then
      new_recipe = 
      {
        type = "recipe",
        name = new_recipe_name,
        category = "scrapping",
        energy_required = 0.5,
        enabled = true,
        hidden = true,
        ingredients =  {{
          name = recipe.name,
          probability = 1,
          amount = 1
        }
        }, 
        icon = "__base__/graphics/icons/list-dot.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "raw-material",
        order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
        results ={{
          name = recipe.name or recipe.result or recipe.results[1].name,
          probability = 0.1,
          amount = 1
        }
        }

        -- results = {{type = "item", name = recipe.ingredients, amount = 1}}
      }
      for input = 1, #recipe.normal.ingredients do
        local amountinput =(recipe.normal.ingredients[input][2] or recipe.normal.ingredients[input].amount)
        local probabilityinput = 0.5 
        if amountinput % 2 == 1 then
          probabilityinput = 0.25
      else
        amountinput = amountinput/2
      end
        
      if (recipe.normal.ingredients[input][1] == "fluid") or (recipe.normal.ingredients[input].type == "fluid") then
        table.insert(new_recipe.results, 
        {type="fluid",
            name = recipe.normal.ingredients[input][1] or recipe.normal.ingredients[input].name,
            probability = probabilityinput,
            amount = amountinput
        })
    else
      table.insert(new_recipe.results, 
      {
          name = recipe.normal.ingredients[input][1] or recipe.normal.ingredients[input].name,
          probability = probabilityinput,
          amount = amountinput
      })
    end


    end
    

      -- table.insert(new_recipe.results, 
      -- {
      --   name = recipe.normal.ingredients[1][1] or recipe.normal.ingredients[1].name,
      --   probability = 0.2,
      --   amount = 1
      -- })
  else
      -- 일반적인 레시피의 처리
      new_recipe = 
      {
        type = "recipe",
        name = new_recipe_name,
        category = "scrapping",
        energy_required = 0.5,
        enabled = true,
        hidden = true,
        ingredients =  {{
          name = recipe.name,
          probability = 1,
          amount = 1
        }
        }, 
        icon = "__base__/graphics/icons/list-dot.png",
        icon_size = 64, icon_mipmaps = 4,
        subgroup = "raw-material",
        order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
        -- results =recipe.ingredients
        results ={{
          name = recipe.name or recipe.result or recipe.results[1],
          probability = 0.1,
          amount = 1
        }
        }
        
        -- results = {{type = "item", name = recipe.ingredients, amount = 1}}
      }


      for input = 1, #recipe.ingredients do
        local amountinput =(recipe.ingredients[input][2] or recipe.ingredients[input].amount)
        local probabilityinput = 0.5 
        if amountinput % 2 == 1 then
          probabilityinput = 0.25
      else
        amountinput = amountinput/2
      end
      if (recipe.ingredients[input][1] == "fluid") or (recipe.ingredients[input].type == "fluid") then
        table.insert(new_recipe.results, 
        {type="fluid",
            name = recipe.ingredients[input][1] or recipe.ingredients[input].name,
            probability = probabilityinput,
            amount = amountinput
        })
    else
      table.insert(new_recipe.results, 
      {
          name = recipe.ingredients[input][1] or recipe.ingredients[input].name,
          probability = probabilityinput,
          amount = amountinput
      })
    end
        -- table.insert(new_recipe.results, 
        -- {
        --     name = recipe.ingredients[input][1] or recipe.ingredients[input].name,
        --     probability = probabilityinput,
        --     amount = amountinput
        -- })
    end
      -- 처리할 코드 작성
  end

  -- 새로운 레시피 데이터 생성


  
  -- {
  --     type = "recipe",
  --     name = new_recipe_name,
  --     enabled = true,
  --     ingredients = recipe.result, -- 결과물이어야 함
  --     result = recipe.ingredients, -- 재료가어야 함
  --     energy_required = 2
  -- }

  -- table.insert(new_recipe.results, 
  -- {
  --   name = recipe.name,
  --   probability = 0.1,
  --   amount = 1
  -- })
  table.insert(new_recipes, new_recipe)
end
::continue::
end



data:extend(new_recipes)


-- local new_recipes = {}
-- local new_recipe

-- for _, recipe in pairs(data.raw["recipe"]) do

--   if not recipe.category or recipe.category == "crafting" or recipe.category == "advanced-crafting" then

--     local second_ingredient = recipe.ItemIngredientPrototype
--     local new_recipe_name = recipe.name .. "-scrapping"


--   -- 새로운 레시피 데이터 생성
--   new_recipe = 
--   {
--     type = "recipe",
--     name = new_recipe_name,
--     category = "scrapping",
--     energy_required = 2,
--     enabled = true,
--     hidden = false,
--     ingredients =  {{
--       name = recipe.name,
--       probability = 1,
--       amount = 1
--     }
--     }, 
--     icon = "__base__/graphics/icons/transport-belt.png",
--     icon_size = 64, icon_mipmaps = 4,
--     subgroup = "raw-material",
--     order = "k[uranium-processing]", -- k ordering so it shows up after explosives which is j ordering
--     results =recipe.ingredients
--     -- results = {{type = "item", name = recipe.ingredients, amount = 1}}
--   }

  
--   -- {
--   --     type = "recipe",
--   --     name = new_recipe_name,
--   --     enabled = true,
--   --     ingredients = recipe.result, -- 결과물이어야 함
--   --     result = recipe.ingredients, -- 재료가어야 함
--   --     energy_required = 2
--   -- }


--   table.insert(new_recipes, new_recipe)
-- end
-- end



-- data:extend(new_recipes)

-- local newRecipe.results={}
-- for _,ingredient in pairs(oldRecipe.ingredients) do
-- local product = {name=ingredient.name, amount=ingredient.amount}
-- table.insert(newRecipe.results, product)
-- end

-- data:extend(newRecipe)