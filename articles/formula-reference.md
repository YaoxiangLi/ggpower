# Formula Reference

Central formulas for all registered ggpower tests. See linked vignettes
for worked examples.

## General power

``` math
\text{Power} = 1 - \beta = P(\text{reject } H_0 \mid H_1)
```

For many tests, power is computed from a noncentral distribution:

``` math
\text{Power} = 1 - F_{H_1}(c) + \text{(one/two-tailed adjustment)}
```

where $`c`$ is the critical value under $`H_0`$ and $`F_{H_1}`$ is the
CDF under $`H_1`$.

------------------------------------------------------------------------

## t tests

### Cohen’s d (one sample / paired)

``` math
d = \frac{\mu_1 - \mu_0}{\sigma}
```

Noncentrality: $`\delta = d\sqrt{n}`$ (one sample, paired).

### Two independent means

``` math
d = \frac{\mu_1 - \mu_2}{\sigma}
```

``` math
\delta = d\sqrt{\frac{n_1 n_2}{n_1 + n_2}}
```

### Point-biserial correlation

Convert $`\rho`$ to $`d`$: $`d = \frac{2\rho}{\sqrt{1-\rho^2}}`$.

### Linear regression slope

``` math
\delta = \frac{(\beta_1 - \beta_0)\sqrt{n}}{\sigma_{\text{residual}}} \cdot \sqrt{\sigma_x^2}
```

### Generic t (direct NCP)

User supplies noncentrality parameter $`\delta`$ and $`df`$ directly.

**Vignette:** [t
Tests](https://yaoxiangli.github.io/ggpower/articles/t-tests.md)

------------------------------------------------------------------------

## F tests and ANOVA

### Cohen’s f from $`\eta^2`$

``` math
f = \sqrt{\frac{\eta^2}{1-\eta^2}}
```

### Noncentrality (omnibus)

``` math
\lambda = f^2 \cdot N \quad \text{or} \quad \lambda = f^2 \cdot (N - k - 1)
```

depending on the test (see registry `method` field).

### Multiple regression $`f^2`$

``` math
f^2 = \frac{R^2}{1-R^2}
```

### $`R^2`$ increase

``` math
f^2 = \frac{R^2_{\text{full}} - R^2_{\text{reduced}}}{1 - R^2_{\text{full}}}
```

### Two variances

``` math
F = \frac{\sigma_1^2}{\sigma_0^2}
```

Power from noncentral F with numerator $`df_1 = 1`$.

**Vignette:** [ANOVA and
Regression](https://yaoxiangli.github.io/ggpower/articles/anova-regression.md)

------------------------------------------------------------------------

## Chi-square tests

### One-sample variance

Test $`\sigma^2`$ against $`\sigma_0^2`$ via $`\chi^2`$ with
$`df = n-1`$.

### Cohen’s w (Gof / contingency)

``` math
w = \sqrt{\sum_i \frac{(p_{1i} - p_{0i})^2}{p_{0i}}}
```

Noncentrality: $`\lambda = N w^2`$.

**Vignette:** [Exact and
Proportions](https://yaoxiangli.github.io/ggpower/articles/exact-and-proportions.md)

------------------------------------------------------------------------

## Exact and proportion tests

### Binomial / one proportion / sign test

``` math
H_0: p = p_0 \quad \text{vs} \quad H_1: p = p_1
```

Exact binomial enumeration or normal approximation for large $`n`$.

### Fisher exact (two proportions)

``` math
H_0: p_1 = p_2
```

Uses hypergeometric enumeration; normal Cohen’s $`h`$ fallback for large
tables.

### McNemar (approximation)

Discordant-pair binomial proxy on $`n_{01}`$ vs $`n_{10}`$.

**Vignette:** [Exact and
Proportions](https://yaoxiangli.github.io/ggpower/articles/exact-and-proportions.md)

------------------------------------------------------------------------

## z tests

### Independent correlations (Fisher Z)

``` math
q = \text{FisherZ}(r_1) - \text{FisherZ}(r_2)
```

``` math
z = \frac{q}{\sqrt{\frac{1}{n_1-3}+\frac{1}{n_2-3}}}
```

### Dependent correlations (Steiger)

Uses covariance of Fisher-Z transformed correlations; see
`z_corr_dependent_*` tests.

### Logistic regression (Wald)

``` math
z = \frac{\log(\text{OR})}{\text{SE}(\log(\text{OR}))}
```

### Poisson regression (Wald)

``` math
z = \frac{\beta_1}{\text{SE}(\beta_1)}
```

### Tetrachoric (approximation)

Large-sample Fisher-Z on tetrachoric $`\rho`$.

**Vignette:** [Correlation and z
Tests](https://yaoxiangli.github.io/ggpower/articles/correlation-and-z-tests.md)

------------------------------------------------------------------------

## Nonparametric tests

### Asymptotic relative efficiency (ARE)

Wilcoxon tests map to equivalent $`d`$ via ARE:

``` math
d_{\text{eff}} = d \cdot \sqrt{\text{ARE}}
```

then reuse t-test noncentrality.

**Vignette:** [Nonparametric
Tests](https://yaoxiangli.github.io/ggpower/articles/nonparametric-tests.md)

------------------------------------------------------------------------

## Biomarker discovery

### ROC AUC — Hanley-McNeil (one sample)

``` math
\text{SE}(A) = \sqrt{\frac{A(1-A) + (n_1-1)(Q_1 - A^2) + (n_0-1)(Q_2 - A^2)}{n_1 n_0}}
```

``` math
z = \frac{A - A_0}{\text{SE}(A)}
```

### Two independent AUCs — DeLong-style

``` math
z = \frac{A_1 - A_2}{\sqrt{\text{Var}(A_1) + \text{Var}(A_2)}}
```

### Diagnostic accuracy

Separate binomial tests for sensitivity and specificity; reported power
is $`\min(\text{Power}_{\text{sens}}, \text{Power}_{\text{spec}})`$.

### Log-rank (Schoenfeld)

``` math
z \approx \frac{|\log(\text{HR})|}{\sqrt{1/D}} \cdot \sqrt{D \cdot p(1-p)}
```

### Cox regression

``` math
z \approx |\log(\text{HR})| \sqrt{E}
```

where $`E`$ is expected events.

### FDR screening

Benjamini-Hochberg at level $`q`$; power from independent two-sample
$`t`$ tests with proportion $`\pi_0`$ true nulls.

**Vignettes:** [ROC /
AUC](https://yaoxiangli.github.io/ggpower/articles/biomarker-roc-auc.md),
[Diagnostic
accuracy](https://yaoxiangli.github.io/ggpower/articles/biomarker-diagnostic-accuracy.md)

------------------------------------------------------------------------

## Clinical trials

### Superiority (continuous)

One-sided two-sample $`t`$: $`\delta = d\sqrt{n_1 n_2/(n_1+n_2)}`$.

### Superiority (binary)

One-sided Fisher / proportion test on $`p_0`$ vs $`p_1`$.

### Non-inferiority (continuous)

``` math
H_0: \mu_T - \mu_C \le -\Delta \quad \text{vs} \quad H_1: \mu_T - \mu_C > -\Delta
```

Shifted mean difference: $`d_{\text{NI}} = d + \Delta/\sigma`$.

### Non-inferiority (binary)

Normal approximation on $`p_T - p_C + \Delta`$.

### Equivalence — TOST

Two one-sided tests:

``` math
\text{Power}_{\text{TOST}} \approx \text{Power}_{\text{upper}} \times \text{Power}_{\text{lower}}
```

### Simon two-stage

``` math
P(\text{success}) = \sum_{k} P(\text{stage 1}) \cdot P(\text{stage 2} \mid \text{stage 1})
```

under $`H_0`$ and $`H_1`$ response rates.

### Cluster RCT design effect

``` math
\text{DE} = 1 + (m - 1) \cdot \text{ICC}
```

Effective $`n_{\text{eff}} = n / \text{DE}`$; then standard two-sample
formulas.

**Vignettes:** [Phase III
superiority](https://yaoxiangli.github.io/ggpower/articles/pharma-phase-iii-superiority.md),
[Non-inferiority](https://yaoxiangli.github.io/ggpower/articles/pharma-non-inferiority.md),
[Equivalence](https://yaoxiangli.github.io/ggpower/articles/pharma-equivalence-tost.md)

------------------------------------------------------------------------

## Related

- [Support
  matrix](https://yaoxiangli.github.io/ggpower/articles/support-matrix.md)
  — all 48 tests with modes and parity
- [Effect size
  conversions](https://yaoxiangli.github.io/ggpower/articles/effect-size-conversions.md)
- [Analysis
  modes](https://yaoxiangli.github.io/ggpower/articles/analysis-modes.md)
- [Approximation
  catalog](https://yaoxiangli.github.io/ggpower/articles/approximation-catalog.md)
