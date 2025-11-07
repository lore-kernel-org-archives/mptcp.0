Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EA13D891
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486689; cv=none; b=pIMqmtm8rgOiLaCidoGSr3amz1JunHqzAax3+1+9IR+XF/DH13hjCcrZt/VoPIIkZXS3ZjABqRm7/aM2qfm+kqEKkXAWX6q6FuIap8BRfs6VQI78nFvHBl46GYNhel4RiZU9LoRRodKz9NMpTW+66ugKhNhEnCYzQU84qfQDxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486689; c=relaxed/simple;
	bh=Mr6kmagnyPdh5SDu9uaqpOYYj3vKbdCtK3achT7ePVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWITxbkPIlJjbHKS4Om++1Xo+W8sjVsb1z3m1HVRV8cNn9KERlMS/uSFxH8PYeVm7QizYuAXzRKmjmjhn7CXodG1JwA0rtYZ2rpGElaKvz9QV+mpUeDng5RjOqpUewE3W59Z3WMS5Zb56lTWNyc3T9j8HpV5JlV8NijdjskE3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq4R17kJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq4R17kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA71C19422;
	Fri,  7 Nov 2025 03:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486689;
	bh=Mr6kmagnyPdh5SDu9uaqpOYYj3vKbdCtK3achT7ePVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gq4R17kJtDNZdrrcfOJTO65Sc3DZnFH/ayoTBsSP9F7B0QdZE7ZRTz9diZgGPgbaS
	 WUicxApFsnQxrLVMQDlhyhmK7JDX4KpEB6hQOWh90/kqf0Eo7EfIp7FYoLt34WyBtL
	 KN0zDDd7f1p6rpSt04o8o0xPOSmwyoIqbxd9A+60z9Y77K1uwyVJWisaegU6k8E3Sy
	 czlVy+dQSHkMPMKe2OKcUreS5091Fxo4deoIKn3NZX79xdHfJurHtrpVPCOb1pe8rU
	 6FazjtwvuV5uQtWS7atBr82bxbZSKmkDPGdlfVecKixL2K2wWKZLWlYYzYV8I9SY0m
	 7GuHAMVlxR3Mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next 4/6] nvme-tcp: add mptcp support
Date: Fri,  7 Nov 2025 11:37:35 +0800
Message-ID: <d75a5fcb788335470fb059ae940d2b6c9007bf9a.1762485513.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines a new nvmf_transport_ops named nvme_mptcp_transport,
which is almost the same as nvme_tcp_transport except .type.

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

Co-Developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-Developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c   | 23 ++++++++++++++++++++++-
 drivers/nvme/target/tcp.c | 10 ++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a80af6471b10..194728ffdf05 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1767,6 +1767,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int proto = IPPROTO_TCP;
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
@@ -1783,9 +1784,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
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
@@ -3024,6 +3030,19 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
+	.create_ctrl	= nvme_tcp_create_ctrl,
+};
+
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
@@ -3049,6 +3068,7 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+	nvmf_register_transport(&nvme_mptcp_transport);
 	return 0;
 }
 
@@ -3056,6 +3076,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+	nvmf_unregister_transport(&nvme_mptcp_transport);
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 066dd88e2449..854b70b4a6f4 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -16,6 +16,7 @@
 #include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/handshake.h>
+#include <net/mptcp.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
 #include <trace/events/sock.h>
@@ -2060,8 +2061,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	if (proto == IPPROTO_MPTCP) {
+		mptcp_sock_set_reuseaddr(port->sock->sk);
+		mptcp_sock_set_nodelay(port->sock->sk);
+	} else {
+		sock_set_reuseaddr(port->sock->sk);
+		tcp_sock_set_nodelay(port->sock->sk);
+	}
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
 
-- 
2.43.0

