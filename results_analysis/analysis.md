Analysis
================
Stuart Miller, Paul Adams, Rikel Djoko

# Power Analysis

The power analysis for this project was done using R package (pwr2).

<https://cran.r-project.org/web/packages/pwr2/pwr2.pdf>

``` r
pwr.2way(a=2, b=3, alpha=0.05, size.A=30, size.B=30, f.A=NULL, f.B=NULL,
delta.A=4, delta.B=2, sigma.A=2, sigma.B=2)
```

    ## 
    ##      Balanced two-way analysis of variance power calculation 
    ## 
    ##               a = 2
    ##               b = 3
    ##             n.A = 30
    ##             n.B = 30
    ##       sig.level = 0.05
    ##         power.A = 1
    ##         power.B = 0.99909
    ##           power = 0.99909
    ## 
    ## NOTE: power is the minimum power among two factors

# Results of Study

## Summary Stats for the Levels

This is assuming that schema is the main driving factor of variation.

    ## # A tibble: 6 x 6
    ## # Groups:   schema [?]
    ##   schema     block_size mean_time median_time IQR_time variance
    ##   <fct>      <fct>          <dbl>       <dbl>    <dbl>    <dbl>
    ## 1 normal     64              124.        124.     5.04    14.1 
    ## 2 normal     128             120.        119.     5.17    16.9 
    ## 3 normal     256             119.        118.     2.58     6.50
    ## 4 Non-normal 64              105.        105.     2.14     3.50
    ## 5 Non-normal 128             101.        101.     2.31     3.60
    ## 6 Non-normal 256             105.        105.     1.11     8.13

## 2-Way ANOVA Profile Plot

Profile plot is colored by schema.

![](analysis_files/figure-gfm/profile_plot-1.png)<!-- -->

## Fit the ANOVA on the Data

This assumes data replication with schema as the primary source of
variation.

    ## 
    ## Error: block_size
    ##           Df Sum Sq Mean Sq F value Pr(>F)
    ## Residuals  2  485.8   242.9               
    ## 
    ## Error: block_size:schema
    ##           Df Sum Sq Mean Sq F value Pr(>F)  
    ## schema     1  13434   13434   93.23 0.0106 *
    ## Residuals  2    288     144                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Error: Within
    ##            Df Sum Sq Mean Sq F value Pr(>F)
    ## Residuals 174   1527   8.778

## Plot Multiple Comparisons

![](analysis_files/figure-gfm/mult_compare-1.png)<!-- -->
