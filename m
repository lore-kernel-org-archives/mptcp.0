Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F317A300
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375206; cv=none; b=mBQcZv3K0eE311FWcEq3C0qPQLvRQp124jljD5LRwGZfvF2VCBoVC41fn+u8eF+fAqK2XzVNfDSaGYC9vWlosz9sNWfb4aAeNaLgyvqTPX1zlZqCzCNepyaXx4FwVVcAZnYSlUyBbw49nk6WXipIRJ4QfaKUvopEquBGnFd1rKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375206; c=relaxed/simple;
	bh=txGusJsb2qe3LEaVFOYsAVYjDe3zgK0OofgTE7CT3bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paZ+xWw8FSFzBKbrdNRINZjxj0MU7jQ35ic2rlM+e9Zngf930V7HgQWc6+OB8W74L5dQ3ETCjrRYR3hyZOGGrugwEC7rJ4SLeZguUu6qBRk2AXFawQHycZ0Fh2ed2cm35JI/DZyX4rFgixaO7QExbV1yGmO5E12j6GVsWozQZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkduPLD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkduPLD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1528C19424;
	Fri, 13 Mar 2026 04:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375205;
	bh=txGusJsb2qe3LEaVFOYsAVYjDe3zgK0OofgTE7CT3bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkduPLD0CJ/VqZY1QjXMkSAxRl9RCq1mvdJERqbC9WDj3lroWX32ArZ4IDloSMb6y
	 Gcgf2Gy1+JjixFkLVIbSSQWAVIySMe7ThHdT0Jj1fD4MePhi0R4S0qztLpyFE6WaXT
	 BoeqHPYFPFnPwIHVtHOu8GSKOsYlal6F76TdrxRdG6mrhFO8cUWkwyrmw1LoC6Jtna
	 u5n4wRi+EvIUQN+U10rASHbkA0UgEJrOznB01LWcGqPPpTbKD7Nlpf4ID7259uGOOO
	 KcnBsYRT0BvV+1bcTixDNIu8mp4vbhK5GjT3WaUsj5OUCqH3ZIGJHNeptjWkElgfp3
	 tkaKZzAD0emfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 6/7] nvme-tcp: add mptcp support
Date: Fri, 13 Mar 2026 12:12:50 +0800
Message-ID: <3fbbe8a82795986d3a14c3e3a89077e8605d416b.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
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

Check if opts->transport is "mptcp" in nvme_tcp_alloc_queue() to decide
whether to pass IPPROTO_MPTCP to sock_create_kern() to create a MPTCP
socket instead of a TCP one.

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
 drivers/nvme/host/tcp.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ab3f61196a3..8ead932e7999 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1766,6 +1766,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int proto = IPPROTO_TCP;
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
@@ -1782,9 +1783,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
+#ifdef CONFIG_MPTCP
+	if (!strcmp(ctrl->ctrl.opts->transport, "mptcp"))
+		proto = IPPROTO_MPTCP;
+#endif
+
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			proto, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1801,9 +1807,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
+	sk_is_msk(queue->sock->sk) ?
+	mptcp_sock_set_syncnt(queue->sock->sk, 1) :
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
+	sk_is_msk(queue->sock->sk) ?
+	mptcp_sock_set_nodelay(queue->sock->sk) :
 	tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
@@ -3022,6 +3032,18 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
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
+
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
@@ -3047,6 +3069,7 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+	nvmf_register_transport(&nvme_mptcp_transport);
 	return 0;
 }
 
@@ -3054,6 +3077,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+	nvmf_unregister_transport(&nvme_mptcp_transport);
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-- 
2.53.0

