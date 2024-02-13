FROM usman89/myrepo:frapee_atd_0.0.3
RUN ls
RUN ls apps/associated_terminals
RUN pwd
RUN git pull apps/associated_terminals
RUN yarn build
CMD ["bash"]