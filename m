Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14F43CEEB
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838406; cv=none; b=X9XS6rVmYWhpK0318EzUcbeGL7zKiFWa7lfX5KyhrXF6JiBuQ3Uz3ldRQkqbWdGgtMugfmVh4AnU2nBE8o4q6u0wQ6UV9jVY+Xln3elouinXj/Ik9aiH9iR8SzNnNvchLIyGK6PIYz7crrowPoZ5bcomJQPstorsCSgbyNfanb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838406; c=relaxed/simple;
	bh=MOIKwVaXmEwicmclLIjAD1s6inLmJTXKkQjJ9N8GyQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o83Oytv+BgTSl+g/c3dJJsWAML3hdKHcFWnqQwg9c5TeQezVlQF/piU9TGPDzFnSRF3tNnWlTpKLARWZZL9hOxSOWFV5dq03sjAyi4R6Kbjrzt4zYL6sNHheYfONG0WBM//t0JFwx9z7VbR4R6PAjB9RohIq2VC666uHaSXXaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB5Q755A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB5Q755A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD383C2BCC7;
	Fri, 15 May 2026 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838406;
	bh=MOIKwVaXmEwicmclLIjAD1s6inLmJTXKkQjJ9N8GyQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pB5Q755AY0ACH+Cs7MINT1GHT9fEHJSgPxUvhFaLYGoat/RQ7YNjYWnpiNWNa4wzV
	 27Jpcuflelleej3pM9vJwnTTC45feJkVlJAxekIxFzpytIth/ATM0X3gUBJqWnT7Y6
	 BjAgvlrTI6U4DfE/LYMnI3iYcOPRkQhf+O615tDESrjGYV4iTS5hBfuY8Rgl6zrm0E
	 amsyB3JroBQ0elTcvMXp0SCRKC1aJD+g9U7MYFnDReh3xBQlCwM+0LFC7vZgzoHvrq
	 /GGJ9BL+3iVwqPtsfWdvUhMMqMYgWhJg1Ate9hP7wbuCFE4ibwv+KMFA9krRv+kD2n
	 1f7iE3NnJWXhQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 5/8] nvme-tcp: register host mptcp transport
Date: Fri, 15 May 2026 17:46:19 +0800
Message-ID: <d890e0f7efba841442e314f81d7260d3052ba857.1778837549.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778837549.git.tanggeliang@kylinos.cn>
References: <cover.1778837549.git.tanggeliang@kylinos.cn>
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

A separate nvme_mptcp_ctrl_ops structure with .name = "mptcp" is defined
and used for MPTCP controllers.

A MODULE_ALIAS("nvme-mptcp") declaration alongside the other module
metadata is added at the end of the file.

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
index f54b1eb86940..bad18d7c323e 100644
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
@@ -3116,3 +3136,4 @@ module_exit(nvme_tcp_cleanup_module);
 MODULE_DESCRIPTION("NVMe host TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvme-tcp");
+MODULE_ALIAS("nvme-mptcp");
-- 
2.53.0

