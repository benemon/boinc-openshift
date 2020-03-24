# BOINC Client for OpenShift

Artifacts to build and run the BOINC client on OpenShift Container Platform without having to resort to running the official image with the `anyuid` SCC.

## Building / Deploying

You can either:

* `oc new-app boinc-client https://github.com/benemon/boinc-openshift.git`

Or, if you want to tweak the Dockerfile:

* `git clone https://github.com/benemon/boinc-openshift.git`
* `oc new-build --name=boinc-client --binary=true`
* `oc new-app boinc-client:latest`

Once built and deployed, you can tweak and update the DeploymentConfig to suit the resources available in your cluster, and the quotas assigned to your projects.

## Configuration

Configuration is applied to the process via environment variables on the DeploymentConfig.

* TZ - Timezone the container will run as
* BOINC_GUI_RPC_PASSWORD - Password for remote management
* BOINC_REMOTE_HOST - IP to listen for remote management requests
* BOINC_CMD_LINE_OPTIONS - Directly configure the BOINC process with its various command line options

Once done, you may end up with something like this:

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
