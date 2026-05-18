Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78430F7EB
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087706; cv=none; b=F58350UI7rh+wx0fzy8JgVRcu0ilVlQz+n8i4fVTKncSJOgwmK+Gz0dVHBMK3QnnyTA2DaovDTZqQGe4DImONKGvVnPLuuWEyx+33Unsqd/wNXTQ9wFzrMcJxSRHmCV0E478PZBy1vwNVKcZTlMOMJlKonnrNrMUpk9bZ6KRWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087706; c=relaxed/simple;
	bh=T5PVauYpREm5lqGwNK4PCnlzussYDdqpb0FkkaPF9UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy6Lr1JnIYhWzVKKkAzSyHda8P36yv+NqX74Q2JDU8GslDGJ7c/qZIchK+kwM9BuOokRrYyNVW/qW53gkoPz6G8dU9NqXP+eugjaagzas1Bq3aFYDdAL3NkqQTgyLICMPjXR/BDKFNkDg2PubCvSj5d85CrniluVzzRCmDSpL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnxdpwsI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnxdpwsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF15C2BCB7;
	Mon, 18 May 2026 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087706;
	bh=T5PVauYpREm5lqGwNK4PCnlzussYDdqpb0FkkaPF9UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnxdpwsIVmUGiUxePDqemaLKoroAcGOO0TIQDSSg+rG/FqMjy4Xb0vD8dRo3MkEVQ
	 AX5sQclF1jfKgBnuP5tZWRBsx0x8dmh8qQ10FSbSQUeA7JQK99zcitOxpAfNvSoKgB
	 SNuWRjOwO/lbnic6hVK8ZTgLnXoqIWmxivEthxs202E13MJod8Ut+KsjsOCDGi62QF
	 4a3EcMVri8uSI5+duIY/hpO++annTAcxWt5pYc+n2yAMddkXfPJI5GfxyALOnpVLPv
	 LQDUno0cUIY48D5COwSBCqjcJwBCzKl+V7Y0TOxJgNlObmfvEpE4Qxx6G2GR2bWZB/
	 hqZ2jLrDNUsGg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 03/11] nvmet-tcp: register target mptcp transport
Date: Mon, 18 May 2026 15:01:22 +0800
Message-ID: <2de5a32abe33bc38c0cbfbdd6ce86266314b39fb.1779087443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
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
index 1cf5a27063d1..858d62e4ceab 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2264,6 +2264,23 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
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
@@ -2277,6 +2294,11 @@ static int __init nvmet_tcp_init(void)
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
@@ -2287,6 +2309,10 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+#ifdef CONFIG_MPTCP
+	if (nvmet_mptcp_registered)
+		nvmet_unregister_transport(&nvmet_mptcp_ops);
+#endif
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
@@ -2306,3 +2332,6 @@ module_exit(nvmet_tcp_exit);
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

