Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260EF405C55
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161114; cv=none; b=rhbA0o8oWQHJk/t4IQGYcTd10yrtCO8dKm+K7TJxbKvsRuQd4MuRsM/Bos2O78LJ8Sk52gx5KHhoWZjL548XylQx2dNpfj0/falpZsAOnA6TLRzCsfH0dxH32mMuh3AgRHpIf3KUBrEII1PnIaR7TVGZZPKaK5yf0NpSKCpWdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161114; c=relaxed/simple;
	bh=UUvFv3HaTOQMLZuvxQv8CMvLc5GBOebOOPuB8FFV5B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkiAuJyIOl4OvR9pUQelJwmQh1smTfLMtsQEy31ASwkTLCTAU+j6jf6H4ZdBQ9X2uR3lFf14Nxz6XPOSGYIRy8/7P0V6AvqDOlpcQqtTXH67Y2nTKven/SmLeIitbSCHsW1TUkW5Zq8S6m2PoiRemhITLnSZev737TGuqJX6yP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=albFilHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="albFilHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA9AC2BCB3;
	Tue, 19 May 2026 03:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779161113;
	bh=UUvFv3HaTOQMLZuvxQv8CMvLc5GBOebOOPuB8FFV5B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=albFilHelObwP1x8UVLIbuULnt3y///c8M9jycZBe7z3RJOV5Z7ZHcRHaX3/HoTxo
	 xSawbStTBQnYSvCxPfU2tn8Z2KwLEFklr6WZkQTPWKgEYOM2ZC1aB0KYMLCxzpwAIX
	 4I8ZbuJaE31ub77zTPnbHSM1rf2ARsz2uTsnlht9Va8k++klPSFTi641Kn4hr4qUzV
	 BWhAPOhVTJLWmw5fsCP67Wb51uUhiFqhGGm3rgZvGCAl3EwKXCOrjdIzaW6gTfinA+
	 9GiF4dhDPnooEzEWO4VVGGtn8H3vepLknrBiwXvF3DD21pHmi1Ef9zOPIq7rl2oksT
	 e7XxnErt6E85g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 01/10] nvmet-tcp: define target tcp_proto struct
Date: Tue, 19 May 2026 11:24:52 +0800
Message-ID: <c796d0260ffebddcaf413f7c5a3d4b3783e814a2.1779159524.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779159524.git.tanggeliang@kylinos.cn>
References: <cover.1779159524.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To add MPTCP support in "NVMe over TCP", the target side needs to pass
IPPROTO_MPTCP to sock_create() instead of IPPROTO_TCP to create an MPTCP
socket. Additionally, the setsockopt operations for this socket need to
be switched to a set of MPTCP-specific functions.

This patch defines the nvmet_tcp_proto structure, which contains the
protocol of the socket and a set of function pointers for these socket
operations.

A TCP-specific version of struct nvmet_tcp_proto is defined. In
nvmet_tcp_add_port(), a local proto variable is set based on trtype.
All locations that previously called TCP setsockopt functions are updated
to call the corresponding function pointers in the nvmet_tcp_proto
structure.

Add kref reference counting to struct nvmet_tcp_port to prevent
use-after-free when a port is removed while queues still hold
references to it. A proto field is added to struct nvmet_tcp_port,
which points to the appropriate protocol structure.

Also validate that the socket protocol matches the port protocol when
allocating a new queue.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 99 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..5276f2369603 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -198,12 +198,24 @@ struct nvmet_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvmet_tcp_proto {
+	int			protocol;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*no_linger)(struct sock *sk);
+	void (*set_tos)(struct sock *sk);
+	const struct nvmet_fabrics_ops *ops;
+};
+
 struct nvmet_tcp_port {
 	struct socket		*sock;
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
+	struct kref		kref;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1081,7 +1093,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->port->proto->ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1597,6 +1610,21 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
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
@@ -1623,6 +1651,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 	page_frag_cache_drain(&queue->pf_cache);
+	nvmet_tcp_port_put(queue->port);
+	queue->port = NULL;
 	kfree(queue);
 }
 
@@ -1696,7 +1726,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1714,14 +1743,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->port->proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->port->proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	queue->port->proto->set_tos(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -1904,6 +1932,13 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
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
@@ -1911,6 +1946,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	struct file *sock_file = NULL;
 	int ret;
 
+	if (port->proto->protocol != newsock->sk->sk_protocol) {
+		ret = -EINVAL;
+		goto out_release;
+	}
+
 	queue = kzalloc_obj(*queue);
 	if (!queue) {
 		ret = -ENOMEM;
@@ -1921,7 +1961,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	kref_init(&queue->kref);
 	queue->sock = newsock;
-	queue->port = port;
+	queue->port = nvmet_tcp_port_get(port);
+	if (!queue->port) {
+		ret = -EINVAL;
+		goto out_free_queue;
+	}
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
 	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
@@ -1936,7 +1980,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
 	if (IS_ERR(sock_file)) {
 		ret = PTR_ERR(sock_file);
-		goto out_free_queue;
+		goto out_put_port;
 	}
 
 	queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
@@ -1999,6 +2043,8 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 out_sock:
 	fput(queue->sock->file);
+out_put_port:
+	nvmet_tcp_port_put(queue->port);
 out_free_queue:
 	kfree(queue);
 out_release:
@@ -2041,6 +2087,24 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static void tcp_sock_set_tos(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	if (inet->rcv_tos > 0)
+		ip_sock_set_tos(sk, inet->rcv_tos);
+}
+
+static const struct nvmet_tcp_proto nvmet_tcp_proto = {
+	.protocol	= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+	.no_linger	= sock_no_linger,
+	.set_tos	= tcp_sock_set_tos,
+	.ops		= &nvmet_tcp_ops,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2051,6 +2115,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (!port)
 		return -ENOMEM;
 
+	kref_init(&port->kref);
+
 	switch (nport->disc_addr.adrfam) {
 	case NVMF_ADDR_FAMILY_IP4:
 		af = AF_INET;
@@ -2065,6 +2131,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		port->proto = &nvmet_tcp_proto;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2079,7 +2152,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2088,10 +2161,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	port->proto->set_reuseaddr(port->sock->sk);
+	port->proto->set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		port->proto->set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
@@ -2146,7 +2219,7 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	nvmet_tcp_destroy_port_queues(port);
 
 	sock_release(port->sock);
-	kfree(port);
+	nvmet_tcp_port_put(port);
 }
 
 static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.53.0

