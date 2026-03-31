Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905D3EE1FD
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952924; cv=none; b=Rj8gx2902l/lOSLgdW3nabhfJIGNAVQkeaiLv8lnubEbGP2z+E6lRIm5e+0u8MmgIdWzM4FgbAc1Q4f/HBG2SqmCZRTtMzK81CUsg9DESzNhc8DOsWW7vUPl9nGFLEMb6r5HAefY8gJatc1m6JB9Qn9yEZdBwcA4OVPst8nN/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952924; c=relaxed/simple;
	bh=K5BE5D/1DQQ/37SUbxY4JuB1sVYIZEygxTM4z2dlUIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfUtUqVXiNhrDq2W+x+Ac5klR0/Ko2m4hqkfYL9mYbWjgD/mUBycHyCdaEfrFWcz8CCa/PDKzQ2tRYw6hh0wHkde8a6rWsjtrhXVFEtGnU5rUNnODkcFdYX7LR5BmN7afd5nfdSXOHTB6Ge9eeqlYzJUzMjxlEES0VN6b0o9nM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjXAsE5a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjXAsE5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED5C2BCB0;
	Tue, 31 Mar 2026 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952924;
	bh=K5BE5D/1DQQ/37SUbxY4JuB1sVYIZEygxTM4z2dlUIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjXAsE5ab8mn/B/PJEIZ8B1+ZlHwYgBgCWe8Z/Z82VBm2teKkuI51s6GZPj8MltK3
	 HygeJqBXAQzcZjcbOMF2DSBN6Yo5nHv59ABm6rkNpBmGDrukbxmQTOq6SyRDQytA/s
	 qwbPBJQraKd4nZcTDvncUyQXVnELhw7LeLu/0yAUzmeoBS9OnA6fPTXs+fyiygfBbK
	 aUAzTAIb9GtNad85bAqaLrpbX9cBczpjB1mvJDOI59eFLrGQlepf9oya5FaS14gaNI
	 BrxHVThboxFe7GwEdm78EzfLOVE1UvepnKO3S+IfwuUQK9VKlujzPavnuBBqrjkiho
	 HywbhECPOs7cA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 3/7] nvmet-tcp: register target mptcp transport
Date: Tue, 31 Mar 2026 18:28:27 +0800
Message-ID: <2f5ae03c4a7511e757c777f6b263a41df286ac26.1774952107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774952107.git.tanggeliang@kylinos.cn>
References: <cover.1774952107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines a new nvmet_fabrics_ops named nvmet_mptcp_ops, which
is almost identical to nvmet_tcp_ops except for the .type field.

It is registered in nvmet_tcp_init() and unregistered in nvmet_tcp_exit().

This new nvmet_fabrics_ops is selected in nvmet_tcp_done_recv_pdu() based
on the protocol type.

A MODULE_ALIAS for "nvmet-transport-4" is also added.

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
 drivers/nvme/target/tcp.c      | 41 +++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

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
index 8471b14a7ee8..1ca9fbbaea92 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -222,6 +222,9 @@ static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
+#ifdef CONFIG_MPTCP
+static const struct nvmet_fabrics_ops nvmet_mptcp_ops;
+#endif
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1037,6 +1040,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
+	const struct nvmet_fabrics_ops *ops;
 	struct nvmet_req *req;
 	int ret;
 
@@ -1077,7 +1081,15 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (queue->sock->sk->sk_protocol == IPPROTO_TCP)
+		ops = &nvmet_tcp_ops;
+#ifdef CONFIG_MPTCP
+	else if (queue->sock->sk->sk_protocol == IPPROTO_MPTCP)
+		ops = &nvmet_mptcp_ops;
+#endif
+	else
+		return -EINVAL;
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -2264,6 +2276,21 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
+#ifdef CONFIG_MPTCP
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
+#endif
+
 static int __init nvmet_tcp_init(void)
 {
 	int ret;
@@ -2277,6 +2304,14 @@ static int __init nvmet_tcp_init(void)
 	if (ret)
 		goto err;
 
+#ifdef CONFIG_MPTCP
+	ret = nvmet_register_transport(&nvmet_mptcp_ops);
+	if (ret) {
+		nvmet_unregister_transport(&nvmet_tcp_ops);
+		goto err;
+	}
+#endif
+
 	return 0;
 err:
 	destroy_workqueue(nvmet_tcp_wq);
@@ -2287,6 +2322,9 @@ static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
 
+#ifdef CONFIG_MPTCP
+	nvmet_unregister_transport(&nvmet_mptcp_ops);
+#endif
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
 	flush_workqueue(nvmet_wq);
@@ -2306,3 +2344,4 @@ module_exit(nvmet_tcp_exit);
 MODULE_DESCRIPTION("NVMe target TCP transport driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("nvmet-transport-3"); /* 3 == NVMF_TRTYPE_TCP */
+MODULE_ALIAS("nvmet-transport-4"); /* 4 == NVMF_TRTYPE_MPTCP */
-- 
2.51.0

