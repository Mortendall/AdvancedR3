
#' Descriptive Stats for lipodomics data
#'
#' @param data
#'
#' @returna data.frame/tibble

descriptive_stats <- function(data) {
  data |>
    dplyr::group_by(.data$metabolite) |>
    dplyr::summarise(dplyr::across(
      .data$value,
      list(
        mean = mean,
        sd = sd,
        iqr = IQR,
        median = median
      )
    )) |>
    dplyr::mutate(dplyr::across(tidyselect::where(is.numeric),
      round,
      digits = 1
    ))
}

#' plot count stats function
#'
#' @param data
#'
#' @return

plot_count_stats <- function(data) {
  metabolite_distribution_plot <- ggplot2::ggplot(
    data,
    ggplot2::aes(x = .data$value)
  ) +
    ggplot2::geom_histogram() +
    ggplot2::facet_wrap(dplyr::vars(.data$metabolite), scales = "free")
  metabolite_distribution_plot
}

#' plot distributions function
#'
#' @param data
#'
#' @return

plot_distributions <- function(data) {
  gender_by_class_plot <- data |>
    dplyr::distinct(.data$code, .data$gender, .data$class) |>
    ggplot2::ggplot(ggplot2::aes(x = class, fill = .data$gender)) +
    ggplot2::geom_bar(position = "dodge")
  gender_by_class_plot
}

#' column to snakecase
#'
#' @param data
#' @param cols
#'
#' @return

column_values_to_snakecase <- function(data, cols) {
  data %>%
    dplyr::mutate(dplyr::across({{ cols }}, snakecase::to_snake_case))
}

#' metabolites to wider
#'
#' @param data
#' @param values_fn
#'
#' @return

metabolites_to_wider <- function(data, values_fn = mean) {
  data |> tidyr::pivot_wider(
    names_from = metabolite, values_from = value, values_fn = values_fn,
    names_prefix = "metabolite_"
  )
}

#' A transformation recipe to pre-process the data.
#'
#' @param data The lipidomics dataset.
#' @param metabolite_variable The column of the metabolite variable.
#'
#' @return
#'
create_recipe_spec <- function(data, metabolite_variable) {
  recipes::recipe(data) %>%
    recipes::update_role({{ metabolite_variable }}, age, gender, new_role = "predictor") %>%
    recipes::update_role(class, new_role = "outcome") %>%
    recipes::step_normalize(tidyselect::starts_with("metabolite_"))
}
