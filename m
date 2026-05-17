Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3E1EB1AA
	for <mptcp@lists.linux.dev>; Sun, 17 May 2026 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997989; cv=none; b=Mku64PbFS2aU6Vr77Qk2Ly1rXuzyn/+znv5dppvtw7M9qQtFW+3v3jgdm3LzBO7JIxX9gkzXMxFpugkAh6SJTpFlAHqSlHVmj7wUP1aTPvh0BtGifSrJogixTAig3BfA8X3wteuX3kQIblAI/67LjNlCAzW8SNwzmNdQRjArJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997989; c=relaxed/simple;
	bh=r43wLVJ/gv12FotweD8iof8f2uIKaHxZa9t8YfpUblA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSfpCAj5eLfp+W4UUSBpoDVUO8OjqjzB14E/5I45Mb1lEW8C190G2rAEdcFXN611BFyhy/MO5Mw582f0hmR4tKP1HVgjo3LM9FsAwBZ+yKRjqZrGZ8JelMtHHEZph51pzzcBcTgiIV4BfpXDGZWzJ91TV+7LWL7RqQjrL06ajiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC+z7dT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC+z7dT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC413C2BCB0;
	Sun, 17 May 2026 06:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778997989;
	bh=r43wLVJ/gv12FotweD8iof8f2uIKaHxZa9t8YfpUblA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iC+z7dT2iYNZmiDXr5Fo0In8sJeTAmQ0dtw9IzhG8dafK6utLPvLcdMlpo33G6O6r
	 nZax7D/+ryOPHV86+Ds/o+1wz1rE0gRYVS+Kjm1PQuv5CyPzUOlqYux5ezumnMuOOW
	 Vx+oJu2P0hpyY11kqxD48+I3iB2OBgoVu8NICwtmgKoDcly1shEVd7CoGC/Co1y/PE
	 RFAvOVgtUdiOuyKOErt2OCLGuziI48RALMjh8qHk3vZDNPOrStSwwHVNevAfgN9kh2
	 01dW9QPnrfTIBuEEhsXVBdblGP1TB/0rbCCd5Jn9Za2FkAET9WOHOrOi9/RxPjsBZt
	 ZVGoZAkYOxc4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 07/10] nvme-tcp: register host mptcp transport
Date: Sun, 17 May 2026 14:05:11 +0800
Message-ID: <40c20921f3d63dcf8cc6583e3ec56b6bd9865b00.1778997507.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778997507.git.tanggeliang@kylinos.cn>
References: <cover.1778997507.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines a new nvmf_transport_ops named nvme_mptcp_transport,
which is almost the same as nvme_tcp_transport except .type and
.allowed_opts.

MPTCP currently does not support TLS. The four TLS-related options
(NVMF_OPT_TLS, NVMF_OPT_KEYRING, NVMF_OPT_TLS_KEY, and NVMF_OPT_CONCAT)
have been removed from allowed_opts. They will be added back once MPTCP
TLS is supported.

It is registered in nvme_tcp_init_module() and unregistered in
nvme_tcp_cleanup_module().

A MODULE_ALIAS("nvme-mptcp") declaration is added at the end of the file.

v2:
 - use 'trtype' instead of '--mptcp' (Hannes)

v3:
 - check mptcp protocol from opts->transport instead of passing a
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
 drivers/nvme/host/tcp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a5aa91c65174..544ac321c20e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3070,6 +3070,20 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
+#ifdef CONFIG_MPTCP
+static struct nvmf_transport_ops nvme_mptcp_transport = {
+	.name		= "mptcp",
+	.module		= THIS_MODULE,
+	.required_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
+			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+	.create_ctrl	= nvme_tcp_create_ctrl,
+};
+#endif
+
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
@@ -3095,6 +3109,9 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+#ifdef CONFIG_MPTCP
+	nvmf_register_transport(&nvme_mptcp_transport);
+#endif
 	return 0;
 }
 
@@ -3102,6 +3119,9 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+#ifdef CONFIG_MPTCP
+	nvmf_unregister_transport(&nvme_mptcp_transport);
+#endif
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
@@ -3119,3 +3139,4 @@ module_exit(nvme_tcp_cleanup_module);
 MODULE_DESCRIPTION("NVMe host TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvme-tcp");
+MODULE_ALIAS("nvme-mptcp");
-- 
2.53.0

