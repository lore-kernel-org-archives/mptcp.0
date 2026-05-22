Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8A23395F
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418121; cv=none; b=FH82n0bPXlB62yVWVdQCEoK2ncs9j3kzbFgVVemxRm19FwVKSaF01JdBHQsfLUlKl7NCRgsP7pjqWhHvPvJthcnMmDcL6ncQiKYswlGjQ+cmmLvNpRyfV5Yckx9tFWX7AQ/0CjdSAMJzE8Zca5O8p7mry4NkMSKxEwIVBqVq7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418121; c=relaxed/simple;
	bh=k9XLsFIXJQ9M7ZzUtSb+GWMMYU82uc2/QsFl6pp+ZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfKskCRovMnkNRFnfHIExW/U+REho4FMwD1CorZfIWFNE5a9sdjBdAz8jogS/mrRInLFhoSExCc7KGH+KMDKDp8BLM1g6XJW+68J15T7esqE77FtTQJMnbfOt5txKbpBRu1awWAsjZX49rh14DNr6LcbXjZ0S9X7pdXghKXNIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8Z9gDOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8Z9gDOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1361F00A3D;
	Fri, 22 May 2026 02:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418120;
	bh=4VA8tM0kRzC/5LAmjHiL1kj+7SlzoiNuS9frNaQdXWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F8Z9gDOWgaJGXoAtY+y2qWrb1JS3UH1f3NwkSs2rRuucltylbFwvwVygaCTLUfPq2
	 ADDvZgggVi1rczQYJQ30VrTp/l/TCybqLXiWfN9+cEO+9JISczfYYNXl9f2+HJuBaj
	 Egi4Zo3mM1RNrEuQwj4R3LL/YnoEsxa/wGu4zf77VQaa0/r+5D11berA+GDD6+ymcN
	 VVxmNhem4mwA9JQFhX+KfBql8Uf9WNxP2ZEmB+Oiv3/9vG2WBiW/sdgQvTmbDm9oHd
	 /tL4rmqXhFWATxfECo9FbIPB/4iv1/eYbsvb/qrlDWN/w5FrvgDYMH3nLbhV1AGhUH
	 lifiEsUuX4vyw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 01/12] nvmet-tcp: define target tcp_proto struct
Date: Fri, 22 May 2026 10:47:59 +0800
Message-ID: <9ed9ef4d1fcc5cb8b898cdb20250c233a97a4c06.1779416980.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779416980.git.tanggeliang@kylinos.cn>
References: <cover.1779416980.git.tanggeliang@kylinos.cn>
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

A proto field is added to struct nvmet_tcp_port, which points to the
appropriate protocol structure.

Also validate that the socket protocol matches the port protocol when
allocating a new queue.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 60 ++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..78043506f444 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -198,12 +198,23 @@ struct nvmet_tcp_queue {
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
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1081,7 +1092,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->port->proto->ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1696,7 +1708,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1714,14 +1725,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
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
@@ -1911,6 +1921,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
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
@@ -2041,6 +2056,24 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
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
@@ -2065,6 +2098,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2079,7 +2119,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2088,10 +2128,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
-- 
2.53.0

