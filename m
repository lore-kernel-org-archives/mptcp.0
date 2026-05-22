Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BB17C203
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418132; cv=none; b=f52vcn9oa/d6Pz/2WGdlH5oTAIthWb2EJVGYDjrXNhAYnFM/obh5poJP+dhJvxVjAkC58rG2deeAYN0xsJMXUED3jNylOLS0OiiATkvOIJOcVZCKATnsnGgs47AdhHdAoXGdbGttmakQYG00Ph26TZCeNqPLM54OHvSb4mVhOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418132; c=relaxed/simple;
	bh=sjnq+9QgTwsffJJ6lQeClsZKTL2GJeyvyjlpyUvSwe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPWveS5p4EexuBY+B7AA80C7eU4f5W1FQ2RFTv/kl4bMOa+65uRvYC9KQiTs4qXtErqzxiU7CDA58+5aK38mpzS3dKEZzLHCDZK9NKOC5CEA6mRXTDcgonsXrwYKRkPAaB1MQim3CjqAyaOonxtjk5Nch+e4vSSKpPhzt42DV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyTXRa3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyTXRa3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10BE1F000E9;
	Fri, 22 May 2026 02:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418131;
	bh=PAXVfS9xrFRog445posgVo0t5kyZk2jApUDLB5PxYxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iyTXRa3ZXPENi7VF1kjlLo4uaaZz6qqHZ83SwC/ggpElGF8xSt1BMFIQZrv86xqif
	 CDRomQu3W7R+A0VeZTY1GKNP8hWZNMGyUeMmyaoT2qK5crObFSaX4OMUT3ZYFoJAv4
	 UOV+JAryGvzxFKKTOuD/7QWiBCjZRjVGACMvWvmds3NtrG+DuCS2cKnybyF+iGmp8x
	 fezw7nae6NKII7x2Q5blI2of9N+rYK9gLPvyJ1/8ZddqfHVhhrryVrFPPnVkDaB5Eb
	 K4sAHm2qzVBHBDVJ2GoltHorg5YCvEHHRieHpLmZGhrrdHLAXaakef2Ed9uYLaB0IX
	 TVvcFFrUqRWgQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 06/12] nvme-tcp: register host mptcp transport
Date: Fri, 22 May 2026 10:48:04 +0800
Message-ID: <20a594d50a4a39468c98830def9d0357b5edfcee.1779416980.git.tanggeliang@kylinos.cn>
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

Cc: Hannes Reinecke <hare@suse.de>
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

