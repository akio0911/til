name :: String
name = "apple"


factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)


total :: [Int] -> Int
total x = div (sum $ zipWith (+) x (reverse x)) 2


total2 :: [Int] -> Int
total2 xs =
  let arr = zipWith (+) xs rev
      rev = reverse xs
  in div (sum arr) 2


factorial' :: Int -> Int
factorial' n = n * factorial' (n - 1)


factorial'' :: Int -> Int
factorial'' 0 = 1

