library(MASS)
library(ggplot2)

data(birthwt)
df <- birthwt

head(df)
str(df)
sum(is.na(df))

df$smoke <- factor(df$smoke, levels = c(0, 1), labels = c("Non-smoker", "Smoker"))
df$race  <- factor(df$race,  levels = c(1, 2, 3), labels = c("White", "Black", "Other"))

table(df$smoke)

aggregate(bwt ~ smoke, data = df,
          FUN = function(x) c(n = length(x), mean = mean(x), sd = sd(x)))

pal <- c("Non-smoker" = "#0F8B8D", "Smoker" = "#E8A33D")

ggplot(df, aes(x = smoke, y = bwt, fill = smoke)) +
  geom_boxplot(alpha = 0.85, color = "#1B2A49") +
  scale_fill_manual(values = pal) +
  labs(title = "Birth weight by maternal smoking status",
       x = NULL, y = "Birth weight (grams)") +
  theme_minimal() +
  theme(legend.position = "none",
        plot.title = element_text(color = "#1B2A49", face = "bold"))

ggplot(df, aes(x = bwt, fill = smoke)) +
  geom_histogram(bins = 20, color = "white") +
  scale_fill_manual(values = pal) +
  facet_wrap(~ smoke) +
  labs(title = "Distribution of birth weight",
       x = "Birth weight (grams)", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none",
        plot.title = element_text(color = "#1B2A49", face = "bold"))

par(mfrow = c(1, 2))
qqnorm(df$bwt[df$smoke == "Non-smoker"], main = "Non-smokers", col = "#0F8B8D", pch = 19)
qqline(df$bwt[df$smoke == "Non-smoker"], col = "#1B2A49", lwd = 2)
qqnorm(df$bwt[df$smoke == "Smoker"], main = "Smokers", col = "#E8A33D", pch = 19)
qqline(df$bwt[df$smoke == "Smoker"], col = "#1B2A49", lwd = 2)
par(mfrow = c(1, 1))

shapiro.test(df$bwt[df$smoke == "Non-smoker"])
shapiro.test(df$bwt[df$smoke == "Smoker"])

t_result <- t.test(bwt ~ smoke, data = df)
t_result

wilcox.test(bwt ~ smoke, data = df, conf.int = TRUE)

smokers     <- df$bwt[df$smoke == "Smoker"]
non_smokers <- df$bwt[df$smoke == "Non-smoker"]
n1 <- length(non_smokers)
n2 <- length(smokers)
pooled_sd <- sqrt(((n1 - 1) * var(non_smokers) + (n2 - 1) * var(smokers)) / (n1 + n2 - 2))
cohens_d <- (mean(non_smokers) - mean(smokers)) / pooled_sd
cohens_d

model1 <- lm(bwt ~ smoke, data = df)
summary(model1)
confint(model1)

model2 <- lm(bwt ~ smoke + age + lwt + race, data = df)
summary(model2)
confint(model2)

par(mfrow = c(2, 2))
plot(model2)
par(mfrow = c(1, 1))


# ==========================================================
# RESULTS
# ==========================================================
# Sample: 189 births (115 non-smokers, 74 smokers), no missing values
#
# Mean birth weight (SD):
#   Non-smokers  3055.7 g (752.7)
#   Smokers      2771.9 g (659.6)
#   Raw difference = 283.8 g
#
# Normality (Shapiro-Wilk):
#   Non-smokers  W = 0.987, p = 0.334
#   Smokers      W = 0.983, p = 0.419   -> no evidence against normality
#
# Welch t-test:
#   t = 2.730, df = 170.1, p = 0.0070
#   95% CI for difference: 78.6 to 489.0 g
#
# Mann-Whitney (Wilcoxon rank-sum):
#   W = 5249.5, p = 0.0068
#   Location shift = 306.2 g (95% CI: 85.0 to 512.0)
#
# Effect size:
#   Cohen's d = 0.395  (small-to-moderate)
#
# Simple regression (bwt ~ smoke):
#   Smoker coefficient = -283.8 g (SE 107.0, p = 0.0087)
#   95% CI: -494.8 to -72.8
#   R-squared = 0.036
#
# Adjusted regression (bwt ~ smoke + age + lwt + race):
#   Smoker   -401.7 g  (95% CI -617.3 to -186.2, p = 0.0003)
#   Age        -1.9 g  (p = 0.843)
#   lwt        +4.0 g per lb (p = 0.022)
#   Black    -510.5 g vs White (p = 0.001)
#   Other    -398.6 g vs White (p = 0.001)
#   R-squared = 0.148, adjusted R-squared = 0.125
#   F(5, 183) = 6.373, p = 1.8e-05
#
# ==========================================================
# CONCLUSION
# ==========================================================
# Babies of mothers who smoked during pregnancy weighed about 284 g less on
# average than babies of non-smokers (Welch t-test p = 0.007, 95% CI 79 to
# 489 g). The Mann-Whitney test agreed (p = 0.007), and the effect size was
# small-to-moderate (Cohen's d = 0.40). After adjusting for maternal age,
# weight and race, the association became larger (-402 g, 95% CI -617 to
# -186, p < 0.001), which suggests confounding by race masked part of the
# smoking effect in the crude comparison.
#
# Limitations: observational data from a single hospital (n = 189), so the
# result shows association, not causation. The model explains only about
# 15% of the variation in birth weight. Smoking is recorded as yes/no, so
# dose-response cannot be assessed, and other factors such as hypertension
# and prior premature labour were not included.
