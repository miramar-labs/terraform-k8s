## Artifacts

Before building the cluster, you will need to download the following installers to the these folders:

[NOMACHINE](https://www.nomachine.com/)

folder: artifacts/general/nomachine/

	nomachine_6.6.8_5_amd64.deb

[NVIDIA Drivers](https://www.nvidia.com/en-us/drivers/unix/): Driver Version: 460.39

[CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit)

folder: artifacts/gpu/

	NVIDIA-Linux-x86_64-460.39.run
	libcudnn8_8.0.4.30-1+cuda11.0_amd64.deb
	libcudnn8-dev_8.0.4.30-1+cuda11.0_amd64.deb

Change any package versions by updating the values in:

	cluster/local.esxi/hosts