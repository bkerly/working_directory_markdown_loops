data("mtcars")

head(mtcars)

mtcars %>%
  transmute(category_cyl = cyl,
         xval_disp = disp,
         yval_hp = hp
         ) %>%
  write_csv(
    file.Dir(
    "data/cars.csv")
  )

data("iris")

head(iris)

iris %>%
  transmute(category_species = Species,
                 xval_Sepal.Length = Sepal.Length,
                 yval_Sepal.Width = Sepal.Width
            ) %>%
  write_csv(
    file.Dir(
    "data/iris.csv")
  )
