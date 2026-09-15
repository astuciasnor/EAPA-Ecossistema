# Function to fit simple and piecewise regression models then plot them using
# temperature as the predictor/independent variable. User can select a response
# variable from the data set, but the data frame muse include a column named
# "Temperature" to use as the predictor.  
# INPUTS:
# y_var    : text string for the response variable to be used in the models
# dataframe: R data frame object that includes the response variable (y_var) and
#            the "Temperature" data column to be used as a predictor variable
# init_bkpt: The initial breakpoint temperature used as a starting value
#            by the piecewise regression model fit from the 'segmented' package
# yaxis_txt: text string for the y-axis plot to name the 'y_var' set above
# label_pos: two-character text string to identify if the breakpoint label 
#            should be places to the top left (tl), top right (tr), bottom
#            left (bl), or bottom right (br). 


piecewise_reg_xtemp <- 
  function(y_var, dataframe, init_bkpt = 20, yaxis_txt, label_pos = "tl", 
           family_string = "Arial", line_col = "tomato", line_type = "solid",
           SE_box_col = "grey") {
    
    # set formula for simple linear regression
    formula_in <- as.formula(paste0(y_var, " ~ temperature"))
    
    # set simple linear model for piecewise regression model to evaluate
    lmfit <- lm(formula = formula_in, data = dataframe)
    
    
    # fit piecewise regression model and estimate breakpoint value
    lm_pr <- 
      segmented(lmfit, seg.Z = ~ temperature, psi = list(temperature = c(init_bkpt)) )
    
    breakpt <- lm_pr$psi[2]  # grabs estimated breakpoint from lm_pr
    breakptSE <- lm_pr$psi[3]  # grabs estimated breakpoint SE from lm_pr
    
    lm_pr_preds <- 
      data.frame(y_var = predict(lm_pr, 
                                 newdata = data.frame(temperature = seq(15,24,0.1))),
                 temperature = seq(15,24,0.1))
    colnames(lm_pr_preds) <- c(y_var, "temperature")
    
    yvar_range <- dataframe[, y_var] |> range() |> diff()
    yvar_min <- dataframe[, y_var] |> min()
    yvar_max <- dataframe[, y_var] |> max()
    
    if(label_pos == "tl") {
      bkpt_anno_sign <- -1
      bkpt_anno_hjust <- 1
      y_anno <- yvar_max
      yend_anno <- yvar_max
    } else if(label_pos == "tr") {
      bkpt_anno_sign <- 1
      bkpt_anno_hjust <- 0
      y_anno <- yvar_max
      yend_anno <- yvar_max
    } else if(label_pos == "bl") {
      bkpt_anno_sign <- -1
      bkpt_anno_hjust <- 1
      y_anno <- yvar_min
      yend_anno <- yvar_min
    } else if(label_pos == "br") {
      bkpt_anno_sign <- 1
      bkpt_anno_hjust <- 0
      y_anno <- yvar_min
      yend_anno <- yvar_min
    }
    
    
    (simp_piece_plot <- 
        ggplot(data = dataframe, 
               aes(x = temperature, y = .data[[y_var]])) +
        
        annotate(geom = "rect", fill = SE_box_col,
                 xmin = breakpt - breakptSE, xmax = breakpt + breakptSE,
                 ymin = -Inf, ymax = Inf, alpha = 1) +
        geom_hline(yintercept = 0, color = "black") +
        
        geom_point() +
        geom_line(data = lm_pr_preds, 
                  aes(x = temperature, y = .data[[y_var]], color = line_col),
                  linewidth = 1, linetype = line_type) +
        geom_vline(xintercept = breakpt, 
                   color = "black", linetype = "dotted", linewidth = 0.5) +
        
        
        # breakpoint line label
        annotate(geom = "curve",
                 x=breakpt+(1*bkpt_anno_sign), y=y_anno, 
                 xend=breakpt+(0.05*bkpt_anno_sign), yend=yend_anno, 
                 curvature = (0.2*bkpt_anno_sign), 
                 arrow = arrow(length = unit(0.25,"cm"), type = "closed")) +
        annotate(geom = "label", x=breakpt+(1.1*bkpt_anno_sign), y=y_anno, 
                 hjust = bkpt_anno_hjust, family = family_string,
                 label = paste0("Breakpoint (\u00B1SE)\n", 
                                round(breakpt,2), "\u00B0C (\u00B1",round(breakptSE,2),") ") ) +
        
        theme_bw() +
        coord_cartesian(ylim = c(yvar_min - (0.06*yvar_range),
                                 yvar_max + (0.06*yvar_range) ) ) +
        labs(x = "Temperature (\u00B0C)", y = yaxis_txt) +
        theme(legend.position = "none", text = element_text(family = family_string))
    )
    
    
    return(list(model = lm_pr, fig = simp_piece_plot))
  }
