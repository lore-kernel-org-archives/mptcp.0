Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D116132F
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486683; cv=none; b=jrjNda3bDagSIMFY2VcYPmpWbSXEujwkPTu3/1KZecQAObPJN47BkzLCmBZB5A/gKV0Oz7T6GLbbOclJij/37x8R7r1aFv51R3aD/GeiALATF28nxvq4/vSgfQ/rC5FjfJy7unKy4nvy/SAMyTMq+XHtK8IromHnZJR/Q0QwhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486683; c=relaxed/simple;
	bh=B27xRBm9gvXU8kqD3icE0nkOJxglruwcgI1VI2A1Peo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGZh5bC/xkI+30s1MyxZfLbEN5HXfzE5hJz9JTyRuwYqL9VBhe5b7qZuZa0HbPH0/o1jR8iBYUkpfjU63eZ7RDIqxmw6WXS2ML0mpBn9j2+LDrRWotUtYes/c9PH+YkW7PLNLTYau/mbSZto0jjErm640ck4Av9TAjMiWOAcBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMaa2xkE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMaa2xkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA077C116C6;
	Fri,  7 Nov 2025 03:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486683;
	bh=B27xRBm9gvXU8kqD3icE0nkOJxglruwcgI1VI2A1Peo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMaa2xkEv3FjMnp8X3kb9IqkfzcaciZuaMTFUtCReacc/YvN2QyyKu4gvlRh0gnAD
	 /FeCPRsIjyU3yLBnZPt8PoWUtVJ/To2Z9L1qiM5MJ7RjYCRmPHfys34rMc0+Gb2FPu
	 55SVMAzR4YJSM5KZdlIFB5mBrDgzWfrW4E+g/4+D11LdgUJElkN4OvMDUU5XUAnx/E
	 1qwDv396o0YGII2chjBYQPyT4HGTW7Go7pdoTctgtWe0GYbPvuVIUoLs7BtnJMbPaU
	 9bto4ZVwRWt5HdhfToXtzJI4L+PKEZhusvFAOpg6ZrhnnFrQbxc5un7hyFU7IA0gso
	 ltr8BZ5MiYu7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next 2/6] nvmet-tcp: add mptcp support
Date: Fri,  7 Nov 2025 11:37:33 +0800
Message-ID: <188ee24f0e00c882748ba8765b8459d226ed554f.1762485513.git.tanggeliang@kylinos.cn>
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

v5:
 - Thanks to Hui Zhu for helping me debug the following list corruption
   issue using gdb:
[   13.043520][  T179] nvmet: adding nsid 1 to subsystem nqn.2014-08.org.nvmexpress.mptcpdev
[   13.197544][  T181] nvmet_tcp: enabling port 1234 (127.0.0.1:4420)
[   13.395800][  T182]  slab MPTCP start ffff8880108f0b80 pointer offset 2480 size 2816
[   13.396422][  T182] list_add corruption. prev->next should be next (ffff8880108f1530), but was ffff8885108f1530. (prev=ffff8880108f1530).
[   13.397064][  T182] ------------[ cut here ]------------
[   13.397305][  T182] kernel BUG at lib/list_debug.c:32!
[   13.397668][  T182] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[   13.397914][  T182] CPU: 1 UID: 0 PID: 182 Comm: nvme Not tainted 6.16.0-rc3+ #1 PREEMPT(full)
[   13.398282][  T182] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 - This issue was finally located in tcp_sock_set_nodelay(). When using MPTCP,
   set_nodelay of TCP cannot be invoked. We need to implement a MPTCP one.

Co-Developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-Developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c        |  4 +++-
 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/tcp.c      | 34 ++++++++++++++++++++++++++++++++--
 include/linux/nvme.h           |  1 +
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6795b8286c35..a80af6471b10 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -19,6 +19,7 @@
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <net/mptcp.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -1804,7 +1805,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	proto == IPPROTO_MPTCP ? mptcp_sock_set_nodelay(queue->sock->sk) :
+				 tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
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
index d543da09ef8e..066dd88e2449 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -212,6 +212,7 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -999,6 +1000,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
+	const struct nvmet_fabrics_ops *ops;
 	struct nvmet_req *req;
 	int ret;
 
@@ -1039,7 +1041,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	ops = queue->sock->sk->sk_protocol == IPPROTO_MPTCP ?
+		&nvmet_mptcp_ops : &nvmet_tcp_ops;
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, ops))) {
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
@@ -2193,6 +2203,19 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
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
@@ -2206,6 +2229,12 @@ static int __init nvmet_tcp_init(void)
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
@@ -2216,6 +2245,7 @@ static void __exit nvmet_tcp_exit(void)
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
2.43.0

