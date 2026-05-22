Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62117C203
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418126; cv=none; b=OJj4cnpiXG5x6cZzwUsQ+NxTNjo/rBVMVzFcegdKPEDQui9C9IF4hj6BsCpyVjjU/IHrzPfxlL5ERS7HCodRC5GVUMxbNOJn4QxD7t6gXWfWyPiT+NgyKFzwdobg8X3lP8qFolHrGnEqBzyRrguP/gJ8FwagVNzDc91QAwjBueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418126; c=relaxed/simple;
	bh=b/OtppE2phlc7Z5upbRXRRLHHx3xgDVP9J1V8rabvFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDeBwPn9f7kalcH7ZPc88am/6ZkHyz/cNZR1SoM1ixHD10fsyRVB6qU1yYkNllFzWvMJKftJJm+O7zBH7aBmHtnXsijyW4IIXvoXzg2Xj7hDnz6b40s8upNIcYnY1I5X8XJm0OYTYTNWZvOqXGsPSrQAKfE0Vo0sBHX9zP13Isw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf5J/+aA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf5J/+aA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218A41F00A3D;
	Fri, 22 May 2026 02:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418124;
	bh=RBkD8RegpDQ7sniGX1HmrQGf82H8xTvStAeCrespgKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rf5J/+aAbNnydEgPHL1w6nq32Fat0l0CVQDxSAl6XtKAUkboGon0+ASeb+7JfRlGV
	 qFLCSwRrqcdPMwyHuPz5PChYvyYdKhbmgMgqzegbC6FQENtqu2pvSFjzTwvzLc7To8
	 ivqyghMjHZ8hCxnPh6l/DpTQmGQyJItRCzS3fD04lrdESaxrDNGbAbTgfFqXr1M6K+
	 Nz8Mm0be7Llr4Nxa8KryHh/vUzQxCydeTUqbyCyRoCNz0uK0MzYwNIC+V3vrLl4imN
	 I8y43EsWGLWwpBnrWdghgqDehMf0ncp77NmxXesR0UTomWREMmr6Wg5XUec6gbc+3a
	 nEe4NYyt0n+EA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 03/12] nvmet-tcp: register target mptcp transport
Date: Fri, 22 May 2026 10:48:01 +0800
Message-ID: <cb37fb4de2a7fc48badcb6de9d6a209ab677e816.1779416980.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779416980.git.tanggeliang@kylinos.cn>
References: <cover.1779416980.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new nvme target transport type NVMF_TRTYPE_MPTCP for
MPTCP. And defines a new nvmet_fabrics_ops named nvmet_mptcp_ops, which
is almost the same as nvmet_tcp_ops except .type. It is registered in
nvmet_tcp_init() and unregistered in nvmet_tcp_exit().

A MODULE_ALIAS for "nvmet-transport-4" is also added.

Note: NVMF_TRTYPE_MPTCP is temporarily assigned 4, a value currently
reserved in the NVMe over Fabrics specification. A request will be
submitted to the NVMe working group to officially allocate this value
for MPTCP.

v2:
 - use trtype instead of tsas (Hannes).

v3:
 - check mptcp protocol from disc_addr.trtype instead of passing a
parameter (Hannes).

v4:
 - check CONFIG_MPTCP.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/tcp.c      | 29 +++++++++++++++++++++++++++++
 include/linux/nvme.h           |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b88f897f06e2..51fc0f4d0c32 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -37,6 +37,7 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
 	{ NVMF_TRTYPE_TCP,	"tcp" },
+	{ NVMF_TRTYPE_MPTCP,	"mptcp" },
 	{ NVMF_TRTYPE_PCI,	"pci" },
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e585dd257fdd..f613302b0ade 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2285,6 +2285,23 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
+#ifdef CONFIG_MPTCP
+static bool nvmet_mptcp_registered;
+
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops = {
+	.owner			= THIS_MODULE,
+	.type			= NVMF_TRTYPE_MPTCP,
+	.msdbd			= 1,
+	.add_port		= nvmet_tcp_add_port,
+	.remove_port		= nvmet_tcp_remove_port,
+	.queue_response		= nvmet_tcp_queue_response,
+	.delete_ctrl		= nvmet_tcp_delete_ctrl,
+	.install_queue		= nvmet_tcp_install_queue,
+	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.host_traddr		= nvmet_tcp_host_port_addr,
+};
+#endif
+
 static int __init nvmet_tcp_init(void)
 {
 	int ret;
@@ -2298,6 +2315,11 @@ static int __init nvmet_tcp_init(void)
 	if (ret)
 		goto err;
 
+#ifdef CONFIG_MPTCP
+	if (!nvmet_register_transport(&nvmet_mptcp_ops))
+		nvmet_mptcp_registered = true;
+#endif
+
 	return 0;
 err:
 	destroy_workqueue(nvmet_tcp_wq);
@@ -2308,6 +2330,10 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+#ifdef CONFIG_MPTCP
+	if (nvmet_mptcp_registered)
+		nvmet_unregister_transport(&nvmet_mptcp_ops);
+#endif
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
@@ -2327,3 +2353,6 @@ module_exit(nvmet_tcp_exit);
 MODULE_DESCRIPTION("NVMe target TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-3"); /* 3 == NVMF_TRTYPE_TCP */
+#ifdef CONFIG_MPTCP
+MODULE_ALIAS("nvmet-transport-4"); /* 4 == NVMF_TRTYPE_MPTCP */
+#endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 041f30931a90..0eada1e0c652 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -68,6 +68,7 @@ enum {
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
 	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
+	NVMF_TRTYPE_MPTCP	= 4,	/* Multipath TCP */
 	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
 	NVMF_TRTYPE_MAX,
 };
-- 
2.53.0

