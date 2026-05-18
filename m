Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8F3FB7D1
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106075; cv=none; b=TzT/JWh6Ritu8ihxLvPMBjizmXR7GbUQZqB4cjxmhEOevJ42LilDCr5gevfCC2RPVBDWL2lVg5IN6BN7X/HeNOWrHstvVS1W1NKd9Jkb84TteeOGMP1CZe3oHjj7hZKEA8DnxOerxH7eCCdXALSxqVrytWkVTKRmrsOynSfNhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106075; c=relaxed/simple;
	bh=rwnGRzDABlIFb9UDOeW/VgtQjT7t1yElAKQ20huo3fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnEbwyxdV/XS/J+BVdCFpdw7i27FgZNMvnOqg8YURRjLyZXwtqbFZo2GO2Cjbclb279VEF2fjdmPFgGCUYQsIfYGfTVWj1vizeHRGjjH9V1MkXYFabrFkp4qTxRrYmMAadYX5wZB4YS2aLRHcsQ6hcaZEKsowbu5zLzsCom+vYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuyewlO4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuyewlO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F297C2BCC6;
	Mon, 18 May 2026 12:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106075;
	bh=rwnGRzDABlIFb9UDOeW/VgtQjT7t1yElAKQ20huo3fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuyewlO4xnnL/i6Z0RhdW6RsFQYCLMUP2UjDS6+O8fZRqmSpCRMyTAnydKBUM1cbs
	 7aCBJa0Ed2VpVvStwIRClW4Yx60Z49T0r6/ycv82Q6JdqHh03ZGLNHuMoyq3hFkegl
	 OSD5rjBavcVKgoXmC1xfOYOVLU6zKZON7dkbqwxKPRNMEXFF5c0rLm2sfDWDxRN7ih
	 Y4qYKZKapKYsSXBZB3/OICN0czOr7bAvz3gle8PJGlz+YLAmS4rOjLpLicPvc6mMBo
	 zlDLuwtKTfYVW9oV/Zn+5IT8GH7HvwVDRMqlEF4tUP/yY5Dyt5WNdpAC33E/JA6DOn
	 cjgBooaGd16hQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 01/12] nvmet-tcp: use tr_ops from nport and add port refcounting
Date: Mon, 18 May 2026 20:07:26 +0800
Message-ID: <ae9bf77e12e0aee43bcf4cac00b33ccb36722dba.1779104752.git.tanggeliang@kylinos.cn>
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

Replace hardcoded nvmet_tcp_ops with queue->port->nport->tr_ops in
nvmet_tcp_done_recv_pdu() to support multiple transport types.

Add kref reference counting to struct nvmet_tcp_port to prevent
use-after-free when a port is removed while queues still hold
references to it.

Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..7fc37ce2c050 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -202,6 +202,7 @@ struct nvmet_tcp_port {
 	struct socket		*sock;
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
+	struct kref		kref;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
 };
@@ -211,7 +212,6 @@ static LIST_HEAD(nvmet_tcp_queue_list);
 static DEFINE_MUTEX(nvmet_tcp_queue_mutex);
 
 static struct workqueue_struct *nvmet_tcp_wq;
-static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
@@ -1081,7 +1081,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->port->nport->tr_ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1597,6 +1598,21 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
+static void nvmet_tcp_port_release(struct kref *kref)
+{
+	struct nvmet_tcp_port *port = container_of(kref,
+						   struct nvmet_tcp_port,
+						   kref);
+
+	kfree(port);
+}
+
+static void nvmet_tcp_port_put(struct nvmet_tcp_port *port)
+{
+	if (port)
+		kref_put(&port->kref, nvmet_tcp_port_release);
+}
+
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1623,6 +1639,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 	page_frag_cache_drain(&queue->pf_cache);
+	nvmet_tcp_port_put(queue->port);
+	queue->port = NULL;
 	kfree(queue);
 }
 
@@ -1904,6 +1922,13 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
 #endif
 
+static struct nvmet_tcp_port *nvmet_tcp_port_get(struct nvmet_tcp_port *port)
+{
+	if (port)
+		kref_get(&port->kref);
+	return port;
+}
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1921,7 +1946,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	kref_init(&queue->kref);
 	queue->sock = newsock;
-	queue->port = port;
+	queue->port = nvmet_tcp_port_get(port);
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
 	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
@@ -2051,6 +2076,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (!port)
 		return -ENOMEM;
 
+	kref_init(&port->kref);
+
 	switch (nport->disc_addr.adrfam) {
 	case NVMF_ADDR_FAMILY_IP4:
 		af = AF_INET;
@@ -2146,7 +2173,7 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	nvmet_tcp_destroy_port_queues(port);
 
 	sock_release(port->sock);
-	kfree(port);
+	nvmet_tcp_port_put(port);
 }
 
 static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.53.0

