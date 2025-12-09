FROM rocker/r-ver:4.3.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /project

# Copy renv.lock first for better caching
COPY renv.lock renv.lock

# Install renv
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

# Copy renv directory if it exists
COPY renv renv

# Restore R packages from renv.lock
RUN R -e "renv::restore()"

# Copy the rest of the project files
COPY data/ data/
COPY report/ report/
COPY code/ code/

# Create output directories
RUN mkdir -p output/tables output/figures

# Set the command to render the report
CMD ["R", "-e", "rmarkdown::render('/project/report/final_report.Rmd', output_dir='/project/output')"]