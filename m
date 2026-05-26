Received: from outbound.qs.icloud.com (qs-2003d-snip4-2.eps.apple.com [57.103.86.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EBD150997
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774710; cv=none; b=QqXAEJ5oW+ROHeIT0ICJjNLHRG3YFRoItMuG/eV++7tfW8TDQzSo6/ILnyYHMeC3o0mjcNdffHsCi8pVbh0o4mcKB5MKs5shia6lF0nDd9N0CtSbiUAvBc0tTzwxdirDFNK/Bj/eO8uxN1gZbiq6U13xHkrhm8dfsJ6AOwL9qY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774710; c=relaxed/simple;
	bh=JEH29/pJEujiAmzJK1yyyuvJA+P/nC7Zn1Y7Z/4NwN4=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:Cc:To; b=IVoZS0i1zhv5Mz8/JIpMTvDZJB8+hIBVjS0oecqypwh9hCIEBFzVt2IjzF/ix1rZzyaQs7OMaB59Ava6G+j1hmkvsXZ7EVIt69X8odXRHxBOvmpylds7jPyi8HAKfZ3u0tJHZIUmobszTZaezuwx1YegfXyFB4kdIYPn15hZw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=b1S9NzgI; arc=none smtp.client-ip=57.103.86.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="b1S9NzgI"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPS id 93A651800151;
	Tue, 26 May 2026 05:51:45 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhACkMFWwFeCEgDQwZeAFBcHA4OXxlbAxcfRghFGVcCVkgEVAIrWxNVF0YJGQhdHRkeV1BeCF4fTBwdDlgGEgJaRQRNXw5eHwQXRhlVBEceXVZCHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPXQVScDV/OnZAdV4GRxRMAS8CRgsyejkeXQVZdDIKO3Zfci52MFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1779774707; x=1782366707; bh=wNCjwKjOAjYjCEo4B1DOXpJOQUciPKCcmvieXwrHR6U=; h=Content-Type:From:Mime-Version:Date:Message-Id:To:x-icloud-hme; b=b1S9NzgIOpUSItvfJxxcWCQ5hTHU+8zRR7it0yQiCsLPuar6ofl6kfHOHJoGdtajiyUv1r5M5p9xUY/7fbdZ7VeT4I/kbFCwfDE+WoIXChr+YfbXj1anjbq3BxVvuAz4ue1JcNotVAqM75LHdVG7S4dER7EU4d97+ni1pBSko/LdFmvsRvhWMOQJ6zDHq8JO61i8cHmO6ve9mvga2RS7mvyMcOgXIknfOAAI6JTBImQKQWo8BTFeFQ1G41qFDFBxVYb+UyZd4SJqKPo6bKnmMZ6nMCEvcE2M2K3Bm7RCtIYkwh+jTUcdy4X5JnGUEtnl8GecAcPes+L5ZEeiViF2lQ==
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-11 (Postfix) with ESMTPSA id D6A51180012F;
	Tue, 26 May 2026 05:51:44 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian C Guerrero <chris.guerrero0795@icloud.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (1.0)
Date: Mon, 25 May 2026 23:51:34 -0600
Message-Id: <029BEFBE-B547-42B5-9BCA-022FB3CE2EED@icloud.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
 Hannes Reinecke <hare@suse.de>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hui Zhu <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
X-Mailer: iPhone Mail (23F77)
X-Proofpoint-GUID: 3QRGupwV5aHlhAseMAmCYejVXKjuOnpy
X-Proofpoint-ORIG-GUID: 3QRGupwV5aHlhAseMAmCYejVXKjuOnpy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0OSBTYWx0ZWRfX9KJ7zpEZPxqr
 lf9HGQZfmVX6J7ENo9qxg8vyXN8TbGMhJTA+O0XHrI6ixcsjACSd4e1JqsiSGTtgZFa4rL9evy6
 DgyhhLazgU+Q0CU6UnPPjK8C8B1ambSQjbamiKngLN8kIsWZYynjsGMZ8OtTcoI4N9xuzTtNqbM
 831va17jeHUbs1osa+6MqkIO8r701rMlZQNLVtlZqN+dVs+FdGQ3lJzv2KHKLHJCSCnIzS7OSom
 3MUWVqZtt9AAc1W3GPooSV+89AbmdfvyCHxeNRIzDHO6Q5fRb2WVnyFqLddurWC89WxNuNX4+o6
 0BVwrI5yGQkB14m9U/R3cY4TwC7ABsI2hUyZLwGXcX2baY9RMAwqblGFKYYu+Y=
X-Authority-Info-Out: v=2.4 cv=KcjfcAYD c=1 sm=1 tr=0 ts=6a1534f2
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=tn3to7fOw0sA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Izl7C0aMf7fbM2bAzYIA:9
 a=QEXdDO2ut3YA:10



> On May 25, 2026, at 3:33=E2=80=AFAM, Geliang Tang <geliang@kernel.org> wro=
te:
>=20
> =EF=BB=BFFrom: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> This patch adds a new nvme target transport type NVMF_TRTYPE_MPTCP for
> MPTCP. And defines a new nvmet_fabrics_ops named nvmet_mptcp_ops, which
> is almost the same as nvmet_tcp_ops except .type. It is registered in
> nvmet_tcp_init() and unregistered in nvmet_tcp_exit().
>=20
> A MODULE_ALIAS for "nvmet-transport-4" is also added.
>=20
> Note: NVMF_TRTYPE_MPTCP is temporarily assigned 4, a value currently
> reserved in the NVMe over Fabrics specification. A request will be
> submitted to the NVMe working group to officially allocate this value
> for MPTCP.
>=20
> Cc: Hannes Reinecke <hare@suse.de>
> Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> drivers/nvme/target/configfs.c |  1 +
> drivers/nvme/target/tcp.c      | 29 +++++++++++++++++++++++++++++
> include/linux/nvme.h           |  1 +
> 3 files changed, 31 insertions(+)
>=20
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs=
.c
> index b88f897f06e2..51fc0f4d0c32 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -37,6 +37,7 @@ static struct nvmet_type_name_map nvmet_transport[] =3D {=

>    { NVMF_TRTYPE_RDMA,    "rdma" },
>    { NVMF_TRTYPE_FC,    "fc" },
>    { NVMF_TRTYPE_TCP,    "tcp" },
> +    { NVMF_TRTYPE_MPTCP,    "mptcp" },
>    { NVMF_TRTYPE_PCI,    "pci" },
>    { NVMF_TRTYPE_LOOP,    "loop" },
> };
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 094f8eb0107e..fa4053cfed12 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2255,6 +2255,23 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops=
 =3D {
>    .host_traddr        =3D nvmet_tcp_host_port_addr,
> };
>=20
> +#ifdef CONFIG_MPTCP
> +static bool nvmet_mptcp_registered;
> +
> +static const struct nvmet_fabrics_ops nvmet_mptcp_ops =3D {
> +    .owner            =3D THIS_MODULE,
> +    .type            =3D NVMF_TRTYPE_MPTCP,
> +    .msdbd            =3D 1,
> +    .add_port        =3D nvmet_tcp_add_port,
> +    .remove_port        =3D nvmet_tcp_remove_port,
> +    .queue_response        =3D nvmet_tcp_queue_response,
> +    .delete_ctrl        =3D nvmet_tcp_delete_ctrl,
> +    .install_queue        =3D nvmet_tcp_install_queue,
> +    .disc_traddr        =3D nvmet_tcp_disc_port_addr,
> +    .host_traddr        =3D nvmet_tcp_host_port_addr,
> +};
> +#endif
> +
> static int __init nvmet_tcp_init(void)
> {
>    int ret;
> @@ -2268,6 +2285,11 @@ static int __init nvmet_tcp_init(void)
>    if (ret)
>        goto err;
>=20
> +#ifdef CONFIG_MPTCP
> +    if (!nvmet_register_transport(&nvmet_mptcp_ops))
> +        nvmet_mptcp_registered =3D true;
> +#endif
> +
>    return 0;
> err:
>    destroy_workqueue(nvmet_tcp_wq);
> @@ -2278,6 +2300,10 @@ static void __exit nvmet_tcp_exit(void)
> {
>    struct nvmet_tcp_queue *queue;
>=20
> +#ifdef CONFIG_MPTCP
> +    if (nvmet_mptcp_registered)
> +        nvmet_unregister_transport(&nvmet_mptcp_ops);
> +#endif
>    nvmet_unregister_transport(&nvmet_tcp_ops);
>=20
>    flush_workqueue(nvmet_wq);
> @@ -2297,3 +2323,6 @@ module_exit(nvmet_tcp_exit);
> MODULE_DESCRIPTION("NVMe target TCP transport driver");
> MODULE_LICENSE("GPL v2");
> MODULE_ALIAS("nvmet-transport-3"); /* 3 =3D=3D NVMF_TRTYPE_TCP */
> +#ifdef CONFIG_MPTCP
> +MODULE_ALIAS("nvmet-transport-4"); /* 4 =3D=3D NVMF_TRTYPE_MPTCP */
> +#endif
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 041f30931a90..0eada1e0c652 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -68,6 +68,7 @@ enum {
>    NVMF_TRTYPE_RDMA    =3D 1,    /* RDMA */
>    NVMF_TRTYPE_FC        =3D 2,    /* Fibre Channel */
>    NVMF_TRTYPE_TCP        =3D 3,    /* TCP/IP */
> +    NVMF_TRTYPE_MPTCP    =3D 4,    /* Multipath TCP */
>    NVMF_TRTYPE_LOOP    =3D 254,    /* Reserved for host usage */
>    NVMF_TRTYPE_MAX,
> };
> --
> 2.53.0
>=20
>=20
