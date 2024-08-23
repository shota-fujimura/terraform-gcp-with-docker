FROM hashicorp/terraform:1.9.3

WORKDIR /terraform

# install bash
RUN apk add --no-cache bash

COPY ./root/.bashrc /root/.bashrc

COPY . /terraform

RUN chmod +x /terraform/home/entrypoint.sh

ENTRYPOINT ["/terraform/home/entrypoint.sh"]