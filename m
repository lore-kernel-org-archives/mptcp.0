Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7F1DF74F
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375199; cv=none; b=DhhnPVA5NyakysDnPbNA89Jl1QhwHqvV1kDYJ4e8fhtif4OlXRwdYGfzIPYNrEmRUaXs2VLagKkxDexNpAD/KxNZRl/d83baOvVBajQAfaYEhYqH2VTd+oDzmqGbrNIw+u5XF1JywzOlQ4S4VgOHOUnyCDBZ+W9Xi0TAj44O7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375199; c=relaxed/simple;
	bh=QonxdimWLUdY5S+w2alNfGjh2kbwr0k5aGh0us6QwPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFpbYIxWYr97mfiyMRj8Y8LbZgycYHjtDYhLVY0cAmDxmiDc+Gj02zZtFxibykvNCmy+/WuYvWsv2LDq2lqpu6F5JOkqVwel7rQqLNv6CpSmuwnOy60iBeqs9hq3nYfhUpLSymUcpFtnTwNLc73mBKr5ERMX/dk9x4wimOCHjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSH388mJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSH388mJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C05C19423;
	Fri, 13 Mar 2026 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375198;
	bh=QonxdimWLUdY5S+w2alNfGjh2kbwr0k5aGh0us6QwPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSH388mJfqxSi6StZYxnWZue5cC8nyO+gywypqVUsSOuoXT54gDiEhERtP6ULEY+U
	 YhzAGAppZC/ehANHoBbjaU44csuLJa/Fcie1+eb9aFE7Msf0+wicf2lVTM/KXXIbnX
	 scC2nL/QZS/rUUFF+2cC6J0+vCLxilwJZQhKrDwzktuEWd/vZwYPkmmQIBLNyGrijD
	 riNMsaxFAWUEvD6gz8myF4jDCyWeIjXVvTSzI0KMWBAnhbufB0a0xLXhTs1cPVyJD/
	 R0apO1wI56SYzy2dx1K+iIjK8JGmjcQjBsI7/ItAfQw/LmcbBjLFRPETAo0s790FVz
	 CcXqAx0xXltFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 4/7] nvmet-tcp: add mptcp support
Date: Fri, 13 Mar 2026 12:12:48 +0800
Message-ID: <3b7fb4de94235c624151cc281e4b965daabcd937.1773374342.git.tanggeliang@kylinos.cn>
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

This patch adds a new nvme target transport type NVMF_TRTYPE_MPTCP for
MPTCP. And defines a new nvmet_fabrics_ops named nvmet_mptcp_ops, which
is almost the same as nvmet_tcp_ops except .type.

Check if disc_addr.trtype is NVMF_TRTYPE_MPTCP in nvmet_tcp_add_port()
to decide whether to pass IPPROTO_MPTCP to sock_create() to create a
MPTCP socket instead of a TCP one.

This new nvmet_fabrics_ops can be switched in nvmet_tcp_done_recv_pdu()
according to different protocol.

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
 drivers/nvme/target/tcp.c      | 38 ++++++++++++++++++++++++++++++++--
 include/linux/nvme.h           |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

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
index acc71a26733f..5111c0e690ee 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -212,6 +212,7 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1067,7 +1068,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     sk_is_msk(queue->sock->sk) ?
+				     &nvmet_mptcp_ops : &nvmet_tcp_ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -2034,6 +2037,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
+	int proto = IPPROTO_TCP;
 	int ret;
 
 	port = kzalloc_obj(*port);
@@ -2054,6 +2058,11 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+#ifdef CONFIG_MPTCP
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_MPTCP)
+		proto = IPPROTO_MPTCP;
+#endif
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2068,7 +2077,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				proto, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2077,7 +2086,11 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
+	sk_is_msk(port->sock->sk) ?
+	mptcp_sock_set_reuseaddr(port->sock->sk) :
 	sock_set_reuseaddr(port->sock->sk);
+	sk_is_msk(port->sock->sk) ?
+	mptcp_sock_set_nodelay(port->sock->sk) :
 	tcp_sock_set_nodelay(port->sock->sk);
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
@@ -2220,6 +2233,19 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
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
+
 static int __init nvmet_tcp_init(void)
 {
 	int ret;
@@ -2233,6 +2259,12 @@ static int __init nvmet_tcp_init(void)
 	if (ret)
 		goto err;
 
+	ret = nvmet_register_transport(&nvmet_mptcp_ops);
+	if (ret) {
+		nvmet_unregister_transport(&nvmet_tcp_ops);
+		goto err;
+	}
+
 	return 0;
 err:
 	destroy_workqueue(nvmet_tcp_wq);
@@ -2243,6 +2275,7 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+	nvmet_unregister_transport(&nvmet_mptcp_ops);
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
@@ -2262,3 +2295,4 @@ module_exit(nvmet_tcp_exit);
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
2.53.0

