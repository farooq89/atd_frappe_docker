FROM usman89/myrepo:frapee_atd_0.0.2
WORKDIR /apps/associated_terminals/dashboard
RUN cd /apps/associated_terminals/dashboard
RUN pwd
RUN ls
RUN git pull https://x-token-auth:ATCTT3xFfGN01ZGPAktgG5e_SQ02ryC4NimdhgBHl57h0aQ0xsEdNyfyOytjlnCok-ErgKPeyRh24Kw31KtDNKVYxTMeaKNQj0sZL2ze8FGCJgNkbqCzXq_-lMU248UkkdGbOWo-4pVSSIYUDI1WnmpR5UYvO_GqwWys-8QmJcBGxm1M-6lKBnY=39B560F8@bitbucket.org/persona-lworkspace/associated-terminals.git
CMD ["bash"]
