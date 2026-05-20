Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674F3438B6
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779250698; cv=none; b=ZPayIRriuC4MbMs/4lvk5HfMEbslOXBvmaFPxdgkuaWcDoCtaqzCZ+dyKimSQyPkRETAASX1yS7iXmE3pIyrp8rVFyjB0gtv9Uv01SHi1+QtRLHo0Y60EHRBNnwghqnwZfBsE4jfglZxRaP501BLnnBX9VWx9qty9NToWnhMfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779250698; c=relaxed/simple;
	bh=ogWf/zrsOAL3UDKqkzALYnzC9lKAQzJkS2Xce2RI7N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a87HfO4CWe6aH2sm8ab35yOkK6vrXS486Ykr/CjOWLYofhAXIWAYb2X2Hpo06ebhnOsEYGnc2tZq/T93nBa9X3AFl+k+h6s86ugfFjDkcijF5Bz8ppod7Va74ej7Xmog5i/2d5y2N9w6JUIGnGDAVrspDrfz5EfOnwqNdRfDB+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwe6alXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwe6alXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366771F00893;
	Wed, 20 May 2026 04:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779250697;
	bh=mKsJejwxSCf+qWQNdVFw5mhujB6ejWJryR5Pfq+OQBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kwe6alXoTJp0nW/twCFltg/j1gDI5Z4j9BJR2r+gK54XC1uoqxsTCNztFqxze6jq6
	 /MLbDGtrzfnSNOxVlyNPVW3Y2GCMlS1A4fBpOxGAhb3wYZghiuA8vg/k6q44LvNUgJ
	 2rX2HvI9dozGvmYxM5wvbdn/nVHo6FB16Zu0ZbQfS1AlR9sizJUe7+gxR1+/B97aGO
	 vvvvGOSrcnLyUXuJCo6zCp7Vj4TdwiYHEYKRikugYJnPmcJ3E4WCfV+jnax5tmz05h
	 rIJyW6WK81PkkCSKGjRXSOMDYoe3saqmcuLUAdQoxe8bRihkkjW65N/jmX9b0cjI8h
	 csndySJ5JR5fA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 05/10] nvme-tcp: register host mptcp transport
Date: Wed, 20 May 2026 12:17:38 +0800
Message-ID: <9b559f953bed2d2ab41a10387e673e5ce878c424.1779249906.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779249906.git.tanggeliang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
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

