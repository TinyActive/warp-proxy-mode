FROM sgabpw/warp-cli:1.9

RUN rm -rf /warp-cli.sh
COPY warp-cli.sh /warp-cli.sh
RUN chmod 755 /warp-cli.sh
ENTRYPOINT ["/warp-cli.sh"]