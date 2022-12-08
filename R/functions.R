
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
