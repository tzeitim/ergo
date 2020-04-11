FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y wget

#RUN useradd --create-home --shell /bin/bash --groups sudo appuser
RUN groupadd -g 999 appuser && useradd --create-home --shell /bin/bash -r -u 999 -g appuser appuser


USER appuser
WORKDIR /home/appuser
RUN mkdir /home/appuser/miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN sh Miniconda3-latest-Linux-x86_64.sh -b -p /home/appuser/miniconda3

# Create the environment:
COPY metacell.yaml .
RUN /home/appuser/miniconda3/bin/conda env create -v -f metacell.yaml

# Make RUN commands use the new environment:
#SHELL ["conda", "run", "-n", "metacell", "/bin/bash", "-c"]
#
## Make sure the environment is activated:
#RUN echo "Make sure flask is installed:"
#RUN python -c "import flask"
#
## The code to run when container is started:
#COPY run.py .
#ENTRYPOINT ["conda", "run", "-n", "myenv"]

