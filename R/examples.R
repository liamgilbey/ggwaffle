ggplot(mpg, aes(class)) +
  geom_bar()

ggplot(mpg, aes(class)) +
  stat_count()

ggplot(mpg, aes(class)) +
  ggplot2::stat_count()

class_object <- mpg %>% pull(class) %>% unique()
classes <- 1:length(class_object)


mpg %>%
  ggplot( aes(x = class), alpha = 0.3) +
  stat_waffle()

mpg %>%
  mutate(class_num = classes[match(mpg$class,class_object)]) %>%
ggplot( aes(x = class_num), alpha = 0.3) +
  stat_waffle()

mpg %>%
  mutate(class_num = classes[match(mpg$class,class_object)]) %>%
  ggplot( aes(x = class_num, fill = class), alpha = 0.3) +
  stat_waffle()

mpg %>%
  mutate(class_num = classes[match(mpg$class,class_object)]) %>%
  ggplot( aes(x = class_num )) +
  stat_waffle(aes(fill = class, alpha = 0.3))


data <- mpg
data$x <- mpg$class
