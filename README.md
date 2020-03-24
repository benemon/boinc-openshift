# BOINC Client for OpenShift

Artifacts to build and run the BOINC client on OpenShift Container Platform without having to resort to running the official image with the `anyuid` SCC.

## Building / Deploying

You can either:

* `oc new-app boinc-client https://github.com/benemon/boinc-openshift`

Or, if you want to tweak the Dockerfile:

* `git clone https://github.com/benemon/boinc-openshift`
* `oc new-build --name=boinc-client --binary=true`
* `oc new-app boinc-client:latest`

Once built and deployed, you can tweak and update the DeploymentConfig to suit the resources available in your cluster, and the quotas assigned to your projects.

## Configuration

Configuration is applied to the process via environment variables on the DeploymentConfig. ALter the BOINC_CMD_LINE_OPTIONS environment variable to configure the project you want BOINC to connect with.

```
          env:
            - name: TZ
              value: Europe/London
            - name: BOINC_GUI_RPC_PASSWORD
              value: openshiftboinc
            - name: BOINC_REMOTE_HOST
              value: 0.0.0.0
            - name: BOINC_CMD_LINE_OPTIONS
              value: >-
                --attach_project http://boinc.bakerlab.org/rosetta/
                YOUR_WEAK_KEY --allow_remote_gui_rpc
                --allow_multiple_clients
```