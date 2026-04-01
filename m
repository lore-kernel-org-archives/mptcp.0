Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0339BFF4
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048057; cv=none; b=qOOkuuVYAKnQKBLUFgtaXx423owUhVuCPPvHIO6sQyk/ScvKNuezR5QOpLrEdra4d2M+hKikqHaqWy50pw61J9xWQIu+1gcAKmFEpoqz1OMG6JGsywIHEHBT0V7N8XwLO2ypbfGUMSxQiKQasrQRAEz2hDKRW+cgEjgx/Nw2zyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048057; c=relaxed/simple;
	bh=GjBdqHu3TDh4vJikVg8CChp0XJ2Yqqvj8KbktsUL7X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhwGhsdTOsO9Z4urE44txYy9M2XqaznL10R5ZpLP/Oo4OJgW6e/E+dk+CjXymTj9aF+NUyfQO3rS+dD78wyd5Pag8IKS8Cd2T3Fjae4m50cWF4m8J3+ippzpIf/0fxdIbead/VT1lhwHwECyGIud7l1AyYHVprdPRaYmA0ikBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJljZ5Dk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJljZ5Dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE72C4CEF7;
	Wed,  1 Apr 2026 12:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775048057;
	bh=GjBdqHu3TDh4vJikVg8CChp0XJ2Yqqvj8KbktsUL7X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJljZ5DkbdJxP8BQAK8prKYoCPqqrO5DfvPbjRS+8Gy5J90AnO2SgvoF9Ld4iaM3Z
	 ekRBKNmXSJQij1xD24Y/mRuZfLTZIqtQYLxkH034Baq211os5mYZLAFpr8TqWFZ06X
	 MWj7wvpi9pyV8Qm+WPWmSPstYMtjKvZ19NcSTi2eEyCvbcbo4MywnHO/bCgL1lGKa8
	 SBWqpw+nRh9DY02o/P2ZMoUqxWme2+63fgsBO9uIc6h6u70S2eLdMU3R7llDpIvhiu
	 4pdNLXaQ4VOsT3gMZU8VAgV6Jxh5j3EitY7hQrcr5cReoNlRLNsc5c+yEy/ndlfun/
	 168H521MAvOGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v8 2/7] nvmet-tcp: register target mptcp transport
Date: Wed,  1 Apr 2026 20:53:40 +0800
Message-ID: <502c21c5ebb8554710aa606327fec3334e3a58d5.1775047736.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775047736.git.tanggeliang@kylinos.cn>
References: <cover.1775047736.git.tanggeliang@kylinos.cn>
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
 drivers/nvme/target/tcp.c      | 27 +++++++++++++++++++++++++++
 include/linux/nvme.h           |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3088e044dbcb..4b7498ffb102 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -38,6 +38,7 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
 	{ NVMF_TRTYPE_TCP,	"tcp" },
+	{ NVMF_TRTYPE_MPTCP,	"mptcp" },
 	{ NVMF_TRTYPE_PCI,	"pci" },
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d8d3d97de8ed..0c1ce80a5179 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2264,6 +2264,21 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
+#ifdef CONFIG_MPTCP
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
@@ -2277,6 +2292,14 @@ static int __init nvmet_tcp_init(void)
 	if (ret)
 		goto err;
 
+#ifdef CONFIG_MPTCP
+	ret = nvmet_register_transport(&nvmet_mptcp_ops);
+	if (ret) {
+		nvmet_unregister_transport(&nvmet_tcp_ops);
+		goto err;
+	}
+#endif
+
 	return 0;
 err:
 	destroy_workqueue(nvmet_tcp_wq);
@@ -2287,6 +2310,9 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+#ifdef CONFIG_MPTCP
+	nvmet_unregister_transport(&nvmet_mptcp_ops);
+#endif
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
@@ -2306,3 +2332,4 @@ module_exit(nvmet_tcp_exit);
 MODULE_DESCRIPTION("NVMe target TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-3"); /* 3 == NVMF_TRTYPE_TCP */
+MODULE_ALIAS("nvmet-transport-4"); /* 4 == NVMF_TRTYPE_MPTCP */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..8069667ad47e 100644
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
2.51.0

