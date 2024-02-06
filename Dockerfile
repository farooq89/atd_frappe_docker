# Use the base image from Docker Hub
FROM usman89/myrepo:frapee_atd_0.0.2
# Run the ls command when the container start
# # Set the working directory
WORKDIR /app

# # Clone the repository
RUN git pull https://x-token-auth:ATCTT3xFfGN01ZGPAktgG5e_SQ02ryC4NimdhgBHl57h0aQ0xsEdNyfyOytjlnCok-ErgKPeyRh24Kw31KtDNKVYxTMeaKNQj0sZL2ze8FGCJgNkbqCzXq_-lMU248UkkdGbOWo-4pVSSIYUDI1WnmpR5UYvO_GqwWys-8QmJcBGxm1M-6lKBnY=39B560F8@bitbucket.org/persona-lworkspace/associated-terminals.git

# RUN ls
# # Push the changes to Docker Hub
# # Replace DOCKER_USERNAME and DOCKER_PASSWORD with your Docker Hub credentials
# # RUN echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin && \
# #     docker push usman89/myrepo:frapee_atd_0.0.2

# # Set the command to run when the container starts
CMD ["bash"]
