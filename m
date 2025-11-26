Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FB315D32
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153634; cv=none; b=Y094U1B8LNG/zW6UFOBSzy1yb6W+FnpJLegjg1chZnnNwmBc4zbzkzWL7VSH3eNyAUI5DTkm3KiC3WvJM6TtY3c9YPL4sDga9MNqZGniGqGagmA53N7hmapMxsoeBNWHH08T19/EYee7C698UJxN/bT3ViLVc2qzgjA+P3sPago=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153634; c=relaxed/simple;
	bh=Hi14LHZtxQEAHLn+tqtbzmJxVrY1bXTCr/ijW47AWlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLpi3Gb2Wwm6An8moQmNXqqWyVLOn9icwcC3sIvm0dCHMGxuqyYpZp6UEQTBLUp5b8LSniTZcZrRaiN+uZ3gxWe6TSvuYKuvp50e3SMbAKSmfBT8IAs5EWiXQtndsHO5h4ARd8TwX/oQwa4qFUMVgvuAuuIC+kgZfqBCGd4zFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0nBRtyS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0nBRtyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9578AC116D0;
	Wed, 26 Nov 2025 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153634;
	bh=Hi14LHZtxQEAHLn+tqtbzmJxVrY1bXTCr/ijW47AWlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0nBRtyS5Kx8B2uNIsR3+dxH5RJ3d5YbEIG1j6tafoayrf7yR2lMB4S1lSW6VZHCh
	 JO7K8F84kkMtpy7M9l4lEq2TtVvI8D7L5rBM5RqTgb5kSQOF/oA1iPv1rxyFq07D+5
	 /hYhvfWqhuOKYHGRnFYPv1d6U7v+BzJ5QLc+TEHQrolOm868Vycs71A71Rq6sqZTxF
	 oAh1e/PIQoj5CjLEyLQE+ILyKXPmv3VOXUjAcxWY3tB/jpG6n4pa19onZpGaiz0zP4
	 DE4wOZt2fNsukBLcjKPhho/R8jC5W9jqsj9vokMBvYdrn+bRnWbYQE4CIIRemUvNEQ
	 fewwx4n0ZScsA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 4/7] nvmet-tcp: add mptcp support
Date: Wed, 26 Nov 2025 18:40:01 +0800
Message-ID: <02bfd26ecf5c2dd9dff8c73138c5e002ae82fab9.1764152990.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764152990.git.tanggeliang@kylinos.cn>
References: <cover.1764152990.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/tcp.c      | 38 ++++++++++++++++++++++++++++++++--
 include/linux/nvme.h           |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44ef69dffc2..14c642cd458e 100644
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
index d543da09ef8e..a0a165d7f9cd 100644
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
@@ -212,6 +213,7 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1039,7 +1041,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->sock->sk->sk_protocol == IPPROTO_MPTCP ?
+				     &nvmet_mptcp_ops : &nvmet_tcp_ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -2007,6 +2011,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
+	int proto = IPPROTO_TCP;
 	int ret;
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
@@ -2027,6 +2032,11 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2041,7 +2051,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				proto, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2050,7 +2060,11 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
+	proto == IPPROTO_MPTCP ?
+	mptcp_sock_set_reuseaddr(port->sock->sk) :
 	sock_set_reuseaddr(port->sock->sk);
+	proto == IPPROTO_MPTCP ?
+	mptcp_sock_set_nodelay(port->sock->sk) :
 	tcp_sock_set_nodelay(port->sock->sk);
 	if (so_priority > 0)
 		sock_set_priority(port->sock->sk, so_priority);
@@ -2193,6 +2207,19 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
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
@@ -2206,6 +2233,12 @@ static int __init nvmet_tcp_init(void)
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
@@ -2216,6 +2249,7 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+	nvmet_unregister_transport(&nvmet_mptcp_ops);
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
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

