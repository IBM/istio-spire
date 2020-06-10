# Istio Identities with SPIFFE/SPIRE

The scripts in this repository demonstrate how to replace the identity-issuing mechanism of Istio with that of Spire.

This repository was tested on Ubuntu 18.04.4 LTS, on a VirtualBox VM.
You will need at least two CPUs to successfully run Istio. We use **Istio 1.5.4**.

We hope that this work would inspire a complete solution to installing Istio with Spire, and we welcome contributions to this effort.

## Replacing the Istio Identity-Issuing Mechanism with that of Spire

**Step 1:** Install Dependencies (you need sudo permissions)
> ./1_install_apt_dependencies.sh

After running this script, run *docker ps* to check whether docker is running properly for your user. If not, try adding permissions to */var/run/docker.sock*:
> sudo chmod 777 /var/run/docker.sock

**Step 2:** Download Kubernetes Kind
> ./2_download_kind.sh

**Step 3:** Download kubectl
> ./3_download_kubectl.sh

**Step 4:** Download Istio 1.5.4
> ./4_download_istio.sh

**Step 5:** Run Kubernetes
> ./5_run_kubernetes.sh

**Step 6:** Run Spire on Kubernetes
> ./6_download_and_run_spire.sh

**Step 7:** Patch Istio Configuration, and run Istio
> ./7_patch_and_run_istio.sh

This script does the following:
1. Copies the default Istio configuration directory to a new *istio_patch* directory
1. Patches the Istio configuration to mount the Spire Unix Domain Socket Directory onto Istio containers
1. Make minor change to the Istio proxy container image
1. Create Spire enties for the Prometheus and Ingress Gateway Istio services
1. Run Istio and wait for all Istio services to come up

**Step 8:** Run a sample workload - a Web server and an Echo server

This workload is based on a workload from the [spire-example](https://github.com/spiffe/spire-examples/tree/master/examples/envoy) repository.
> ./8_install_workload.sh

This script compiles the code for the web and echo servers, and then deploys them on Istio. Finally it runs firefox on the web server page.

On the web browser you will see the following message:
> upstream connect error or disconnect/reset before headers. reset reason: connection failure

Why is that? Because **neither the web server nor the echo server have an identity yet**, and can therefore not receive any communications. In order to fix that, first run:
> ./spire/setup_spire_web.sh

Refresh the page on the browser. You will see the *Send to Echo Server* button. If you press it you will get an error message, because the echo server does not yet have an identity. Now run:
> ./spire/setup_spire_echo.sh

If you press the button again, you will see the message that was returned from the echo server.

## Notes

If you have any questions or issues you can create a new [issue here][issues].

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

<!-- License and Authors is optional here, but gives you the ability to highlight who is involed in the project -->
## License & Authors

If you would like to see the detailed LICENSE click [here](LICENSE).

```text
Copyright:: 2019- IBM, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```


[issues]: https://github.com/IBM/istio-spire/issues/new
