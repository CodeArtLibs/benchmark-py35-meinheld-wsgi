FROM ubuntu:14.04

# Installing Linux packages
RUN apt-get -y update
RUN apt-get install -y build-essential

# Installing Python
RUN apt-get -y install python-dev python-pip

# Installing Python packages
RUN pip install supervisor==3.2.0 virtualenv==14.0.0

# Code + Benchmark configuration
RUN apt-get -y install libev-dev
COPY requirements.txt /src/requirements.txt
COPY run.py /src/run.py
COPY supervisord.conf /src/supervisord.conf
WORKDIR /src
RUN virtualenv env -p python
RUN env/bin/pip install -r requirements.txt

# Important for ELB
EXPOSE 8000

CMD ["supervisord", "-z", "0", "-c", "/src/supervisord.conf"]

# Information
WORKDIR /src
RUN env/bin/python -c 'import struct ; import sys ; print("Python %s\n%sbits" % (sys.version, 8 * struct.calcsize("P")))'
RUN env/bin/python -c 'import sys ; print(sys.maxunicode)'
