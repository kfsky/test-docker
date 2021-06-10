FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
	sudo \
	wget \
	vim

WORKDIR /opt
RUN wget https://repo.continuum.io/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
	sh Anaconda3-2019.10-Linux-x86_64.sh -b -p /opt/anaconda3 && \
	rm -f Anaconda3-2019.10-Linux-x86_64.sh

ENV PATH /opt/anaconda3/bin:$PATH

# COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install \
	xfeat \
	python-vivid \
	geopy 
# RUN pip install -r requirements.txt &&\
# 	rem -rf ~/.cache/pip

RUN conda install -y conda &&\
	conda install -y \
		pytorch \
		torchvision &&\
	conda install -c conda-forge \
		lightgbm \
		category_encoders \
		xgboost \
		libiconv \
		keras \
		tensorflow && \
	conda clean -i -t -y

WORKDIR /
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"] 