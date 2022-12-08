
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
