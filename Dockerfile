FROM usman89/myrepo:frapee_atd_0.0.3
RUN git pull apps/associated_terminals
RUN yarn build
CMD ["bash"]