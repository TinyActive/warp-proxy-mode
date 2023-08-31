FROM caomingjun/warp

RUN rm -rf /entrypoint.sh
COPY warp-cli.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]