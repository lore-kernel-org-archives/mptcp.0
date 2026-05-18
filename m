Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B63FBEA9
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106088; cv=none; b=bpLGdfdcTjQ6ZtuCtpUVNE/yv5k6/ALHPm5zINhMRzlbx16dZkuOWpz2rPHZ6VHBYC+lzwUERe7AkIHlspWfjtYKh5CYBYKjHlWrJtIZTosSG+SkFwj6nlPYMyjID0c4Gu4yA+5ESwqOHm5Dw8u1TzuqIxu/+CB35MMzXp3f3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106088; c=relaxed/simple;
	bh=ogWf/zrsOAL3UDKqkzALYnzC9lKAQzJkS2Xce2RI7N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1Mg6Ik6E6wIketSQ2t2oIpHf3LQbtTVAc3Rtv3AXdTsiGp56irQK3h+eoJEQ8V4h0zfYaxWEqAt+REfHQVNeXwmIoVbBMnxi0hXgKxpCbNbdxz34oL0Y4WvmlDQTUkdpkCI8K5LbGryIOYyUKYhuu+x2Ex5tkUo+sj62YNFZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfYHO763; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfYHO763"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32552C2BCC6;
	Mon, 18 May 2026 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106087;
	bh=ogWf/zrsOAL3UDKqkzALYnzC9lKAQzJkS2Xce2RI7N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfYHO76370sLPPr7wURlpXeQHIKSwwOjRmD64/w3mca82haoR0trOiSU2WLmz7BkQ
	 hkTg8hPAFYm/3U07ZCQquomaUwQQXmqct/yJcNfqVZLY9fpImvbIOWxz2EkOYBnEmE
	 nFx1rduBpf5tAUORYee70CuMFbt1BXhmA7UOzkMgD2PRN31sGncFaybwuKtIzXQo4T
	 3adLUOrTdFXbteyoOY/KmoJ73HpLZs5IcAH/YzPOsm0Qj3KFWlhjF7z1MpMkkw7TOi
	 yQthxOB+uTTb9bt+o/jj6ZjUZaj825E9dWXFXS1dQC2NlPBEYpN170fBna3Ec4YKu6
	 gEBnBAnAB5ccA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 06/12] nvme-tcp: register host mptcp transport
Date: Mon, 18 May 2026 20:07:31 +0800
Message-ID: <344d157ea7c2086ba8f6bccd714016918e6180f8.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines a new nvmf_transport_ops named nvme_mptcp_transport,
which is almost the same as nvme_tcp_transport except .name and
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

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 13a5240623ef..305624d59c50 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3067,6 +3067,20 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
@@ -3092,6 +3106,9 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+#ifdef CONFIG_MPTCP
+	nvmf_register_transport(&nvme_mptcp_transport);
+#endif
 	return 0;
 }
 
@@ -3099,6 +3116,9 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+#ifdef CONFIG_MPTCP
+	nvmf_unregister_transport(&nvme_mptcp_transport);
+#endif
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
@@ -3116,3 +3136,6 @@ module_exit(nvme_tcp_cleanup_module);
 MODULE_DESCRIPTION("NVMe host TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvme-tcp");
+#ifdef CONFIG_MPTCP
+MODULE_ALIAS("nvme-mptcp");
+#endif
-- 
2.53.0

