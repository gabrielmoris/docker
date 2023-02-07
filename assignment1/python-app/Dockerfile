FROM python

WORKDIR /app

COPY . .

CMD ["python", "bmi.py"]

# After this in command Line:
# > docker build -t pythoassignment:version0 .
# docker run -p [local port]:[container expose port] <image id generated in build>
# > docker run -it --rm --name bmi 6696410feab6 <image id generated in build>