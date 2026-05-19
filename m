Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B10405C55
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161116; cv=none; b=VMk/fg5wwXcXToznwKvKQ9GTpx+CDiy1vXFVVPN8WN6lGZUXE1fOa7aGhyS51N72K0P7/1dpVSc2rW8Jy+p9uO6YrLX23zveglwjibwrOT1y2zjhnR4ja+K+kTk2UAspQ0zxnlMUFutkkXZHoQtr4c0YynavTqC3JBGAYhcdiFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161116; c=relaxed/simple;
	bh=pLAVpCCIPS/O+y7SNmiCpabsi85KvPIPfU2yoth5Eog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdTy5bhZCGqMdlkomBytX2w9ymZvm/VA54d/v93mxzKix5i+b0BWT9xMpo09fIjx//sVKbb0uYySqVrfBluXDNaMojNba96jkDnZ4l6RPM9J3SkZ8GhTIkbP65g2EEDnGPQT5Q/7i8s98tzfBXjZjXFqi2UlCCk4S715q3v4Bkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEFfOioI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEFfOioI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68740C2BCB8;
	Tue, 19 May 2026 03:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779161116;
	bh=pLAVpCCIPS/O+y7SNmiCpabsi85KvPIPfU2yoth5Eog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEFfOioIwsc4DbwDngkN/uXykadNF3vdFAULasEE0VG+CULgqpfhe2LBQRQ7Mc6bU
	 y5NPhfqK6NcGGVDjJG7mYSj+e18i56YGg9xMDR9Zj32l19YuO6DaJ6U9jSadgixWoy
	 XFRXlo3FSnXZrQ/ZPDxsmX0n4Y5fWZ0U9GOepKpxrc2a+biO3uWk3bSUUfxSilGFcY
	 4iBze88rmHqhhDCrL5beGAS14DF93s/RvwkWoOgYoL5VwcPej8IGui9s+7tl85qLdL
	 wbjBFzyDO/83AP2yh/uDsKfvVY7yrUOseY11Vh1qDD1KdHT0zMZ5BbFY1/GOwvoLHm
	 v27rR0WuH68Qg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 02/10] nvmet-tcp: register target mptcp transport
Date: Tue, 19 May 2026 11:24:53 +0800
Message-ID: <d23234abdb4cec9fee1fe7fdadb28e25f5d997ed.1779159524.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779159524.git.tanggeliang@kylinos.cn>
References: <cover.1779159524.git.tanggeliang@kylinos.cn>
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
index 5276f2369603..9cd9bb15011e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2304,6 +2304,23 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
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
@@ -2317,6 +2334,11 @@ static int __init nvmet_tcp_init(void)
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
@@ -2327,6 +2349,10 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+#ifdef CONFIG_MPTCP
+	if (nvmet_mptcp_registered)
+		nvmet_unregister_transport(&nvmet_mptcp_ops);
+#endif
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
@@ -2346,3 +2372,6 @@ module_exit(nvmet_tcp_exit);
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

